Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C385C392C18
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 12:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbhE0Kqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 06:46:33 -0400
Received: from hel-mailgw-01.vaisala.com ([193.143.230.17]:55910 "EHLO
        hel-mailgw-01.vaisala.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbhE0Kqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 06:46:32 -0400
Received: from HEL-SMTP.corp.vaisala.com (HEL-SMTP.corp.vaisala.com [172.24.1.225])
        by hel-mailgw-01.vaisala.com (Postfix) with ESMTP id 2FB2160C7630;
        Thu, 27 May 2021 13:44:52 +0300 (EEST)
Received: from localhost.localdomain ([172.24.252.96]) by HEL-SMTP.corp.vaisala.com over TLS secured channel with Microsoft SMTPSVC(8.5.9600.16384);
         Thu, 27 May 2021 13:44:55 +0300
Subject: Re: [PATCH v4 0/4] Bootcount driver using NVMEM cell as backend.
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1620211180.git.nandor.han@vaisala.com>
From:   Nandor Han <nandor.han@vaisala.com>
Message-ID: <ea0600ab-3ccb-159d-fbf4-702e75ad348f@vaisala.com>
Date:   Thu, 27 May 2021 13:44:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <cover.1620211180.git.nandor.han@vaisala.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 May 2021 10:44:55.0035 (UTC) FILETIME=[548EC4B0:01D752E5]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/21 1:42 PM, Nandor Han wrote:
> Description
> -----------
> Implement a bootcount (1) related driver that uses
> NVMEM as a backend. The patchset will also update the
> `snvs_lpgpr` driver to support 2 bytes NVMEM cells.
> 
Any feedback about this patchset?

-- 
Regards,
    Nandor
