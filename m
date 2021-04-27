Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016F436C6EF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236351AbhD0NWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:22:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236008AbhD0NWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:22:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CDAE6103E;
        Tue, 27 Apr 2021 13:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619529732;
        bh=AezlWqwbEGtZqPVHShwtEtBb13X2UisKWaxEjAcpl5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KCIzamMePfwJpjx+LELtJgLwQ+D/nN99Z9r7ewUiF6RlW5lN4v+FmrSeOwjSXWPBz
         fvNRq2DDHrHxUzTCOAR2S8LZMoCk7aWw3Juu0PeDqlDI+8KLL+x3/qCmvLbiSzB+EH
         Dfr3zZUTAP6EJvN3z3axXA0mKpRTg3WlXzal3yQo=
Date:   Tue, 27 Apr 2021 15:22:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH 151/190] Revert "media: gspca: Check the return value of
 write_bridge for timeout"
Message-ID: <YIgQAYjYQU08gpoI@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-152-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-152-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:26PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit a21a0eb56b4e8fe4a330243af8030f890cde2283.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/media/usb/gspca/m5602/m5602_po1030.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/usb/gspca/m5602/m5602_po1030.c b/drivers/media/usb/gspca/m5602/m5602_po1030.c
> index d680b777f097..7bdbb8065146 100644
> --- a/drivers/media/usb/gspca/m5602/m5602_po1030.c
> +++ b/drivers/media/usb/gspca/m5602/m5602_po1030.c
> @@ -154,7 +154,6 @@ static const struct v4l2_ctrl_config po1030_greenbal_cfg = {
>  
>  int po1030_probe(struct sd *sd)
>  {
> -	int rc = 0;
>  	u8 dev_id_h = 0, i;
>  	struct gspca_dev *gspca_dev = (struct gspca_dev *)sd;
>  
> @@ -174,14 +173,11 @@ int po1030_probe(struct sd *sd)
>  	for (i = 0; i < ARRAY_SIZE(preinit_po1030); i++) {
>  		u8 data = preinit_po1030[i][2];
>  		if (preinit_po1030[i][0] == SENSOR)
> -			rc |= m5602_write_sensor(sd,
> +			m5602_write_sensor(sd,
>  				preinit_po1030[i][1], &data, 1);
>  		else
> -			rc |= m5602_write_bridge(sd, preinit_po1030[i][1],
> -						data);
> +			m5602_write_bridge(sd, preinit_po1030[i][1], data);
>  	}
> -	if (rc < 0)
> -		return rc;
>  
>  	if (m5602_read_sensor(sd, PO1030_DEVID_H, &dev_id_h, 1))
>  		return -ENODEV;
> -- 
> 2.31.1
> 

You do not OR error values together and expect the end result to be
anything sane, so I am keeping this revert as it is incorrect.

thanks,

greg k-h
