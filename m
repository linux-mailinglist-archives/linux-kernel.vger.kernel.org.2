Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC8B32A87F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351671AbhCBRiN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 2 Mar 2021 12:38:13 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:60753 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384447AbhCBPFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:05:20 -0500
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 429213ADF36;
        Tue,  2 Mar 2021 14:52:02 +0000 (UTC)
X-Originating-IP: 86.206.8.148
Received: from xps13 (lfbn-tou-1-491-148.w86-206.abo.wanadoo.fr [86.206.8.148])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 1F8F2C000E;
        Tue,  2 Mar 2021 14:47:39 +0000 (UTC)
Date:   Tue, 2 Mar 2021 15:47:38 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Conor Culhane <conor.culhane@silvaco.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i3c@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] i3c: master: svc: remove redundant assignment to
 cmd->read_len
Message-ID: <20210302154739.00cd4a22@xps13>
In-Reply-To: <20210224151349.202332-1-colin.king@canonical.com>
References: <20210224151349.202332-1-colin.king@canonical.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin King <colin.king@canonical.com> wrote on Wed, 24 Feb 2021
15:13:49 +0000:

> From: Colin Ian King <colin.king@canonical.com>
> 
> The assignment of xfer_len to cmd->read_len appears to be redundant
> as the next statement re-assigns the value 0 to it.  Clean up the
> code by removing the redundant first assignment.
> 
> Addresses-Coverity: ("Unused value")
> Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/i3c/master/svc-i3c-master.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index 8d990696676e..1f6ba4221817 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -1124,7 +1124,6 @@ static int svc_i3c_master_send_direct_ccc_cmd(struct svc_i3c_master *master,
>  	cmd->in = NULL;
>  	cmd->out = &ccc->id;
>  	cmd->len = 1;
> -	cmd->read_len = xfer_len;
>  	cmd->read_len = 0;
>  	cmd->continued = true;
>  

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl
