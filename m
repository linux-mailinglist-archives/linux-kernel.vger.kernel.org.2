Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2044E3B08EA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbhFVP2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:28:18 -0400
Received: from p3plsmtpa06-04.prod.phx3.secureserver.net ([173.201.192.105]:39185
        "EHLO p3plsmtpa06-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231815AbhFVP2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:28:16 -0400
Received: from [192.168.0.100] ([96.237.161.203])
        by :SMTPAUTH: with ESMTPSA
        id viAjleA5hyubKviAklUeJx; Tue, 22 Jun 2021 08:18:42 -0700
X-CMAE-Analysis: v=2.4 cv=avN3tQVV c=1 sm=1 tr=0 ts=60d1ff52
 a=Pd5wr8UCr3ug+LLuBLYm7w==:117 a=Pd5wr8UCr3ug+LLuBLYm7w==:17
 a=IkcTkHD0fZMA:10 a=yMhMjlubAAAA:8 a=SEc3moZ4AAAA:8 a=WtrXtaRitKTu45twBd0A:9
 a=QEXdDO2ut3YA:10 a=5oRCH6oROnRZc2VpWJZ3:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [SMBDIRECT][PATCH] missing rc checks while waiting for SMB3 over
 RDMA events
To:     Steve French <smfrench@gmail.com>, Long Li <longli@microsoft.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <CAH2r5msOSLaZT42-jFMjJrB1YiYTZBzdM18ieqQY2v=YwXzcrA@mail.gmail.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <1241844c-c9ab-2055-a363-80db63a4dd22@talpey.com>
Date:   Tue, 22 Jun 2021 11:18:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAH2r5msOSLaZT42-jFMjJrB1YiYTZBzdM18ieqQY2v=YwXzcrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfHuI+aivFMuuZGehMwo60U0hMxx4SRlZRovOfkVEQV+DSNr7Xsgr24M1GrRqkHKlEcIEK+uWkTiIMKBUCjvZ58HFuk8/Dd/oXj4kDTj8r+LIbJTT9Wgw
 uCxr9bQrLlMcs9Gi98JmKYOsxS7kwHj5xyQKsK+BbVYVRkoyp96CPTa6hGbejTDjrtsLWkRg0yQ/8trMfUgSgZyhFdcx1CoroewBJRQsFS4yT1Zld/TuvfBs
 bZ6vADug7cS7eXqCfY/CXUStivJNypo3m9iBNrrE/DmlV7ezTzfNA55513B31uhc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/2021 5:32 PM, Steve French wrote:
>      There were two places where we weren't checking for error
>      (e.g. ERESTARTSYS) while waiting for rdma resolution.
> 
>      Addresses-Coverity: 1462165 ("Unchecked return value")
>     Signed-off-by: Steve French <stfrench@microsoft.com>
> 
> diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
> index 10dfe5006792..ae07732f750f 100644
> --- a/fs/cifs/smbdirect.c
> +++ b/fs/cifs/smbdirect.c
> @@ -572,8 +572,11 @@ static struct rdma_cm_id *smbd_create_id(
>                  log_rdma_event(ERR, "rdma_resolve_addr() failed %i\n", rc);
>                  goto out;
>          }
> -       wait_for_completion_interruptible_timeout(
> +       rc = wait_for_completion_interruptible_timeout(
>                  &info->ri_done, msecs_to_jiffies(RDMA_RESOLVE_TIMEOUT));
> +       /* -ERESTARTSYS, returned when interrupted, is the only rc mentioned */

Suggest the same comment text as the one below, this one seems uncertain.

> +       if (rc < 0)
> +               goto out;
>          rc = info->ri_rc;
>          if (rc) {
>                  log_rdma_event(ERR, "rdma_resolve_addr() completed %i\n", rc);
> @@ -586,8 +589,10 @@ static struct rdma_cm_id *smbd_create_id(
>                  log_rdma_event(ERR, "rdma_resolve_route() failed %i\n", rc);
>                  goto out;
>          }
> -       wait_for_completion_interruptible_timeout(
> +       rc = wait_for_completion_interruptible_timeout(
>                  &info->ri_done, msecs_to_jiffies(RDMA_RESOLVE_TIMEOUT));
> +       if (rc < 0)  /* e.g. if interrupted and returns -ERESTARTSYS */

delete "and"?

> +               goto out

Missing a semicolon.     ^^^

>          rc = info->ri_rc;
>          if (rc) {
>                  log_rdma_event(ERR, "rdma_resolve_route() completed %i\n", rc);
> 
> 

One meta-comment. There's no message logged for these ERESTARTSYS cases.
That might be confusing in the log, if they lead to failure.

Reviewed-By: Tom Talpey <tom@talpey.com>

Tom.
