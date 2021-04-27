Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCF536C6F2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbhD0NX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:23:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236008AbhD0NX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:23:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D40EB61168;
        Tue, 27 Apr 2021 13:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619529764;
        bh=803J1MayeV5HpyHRIF7516B7VPNjxdHVYCSgoVggRCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KxAVmLDVBbUC6Qrk3VoSuhjtbQPQap2aFTV+PtN/Oaf3nLircE07zJh7ahnPmCUD4
         1nxtoxqPHrnVxENF4z3A1BdOFgKn24gRigILdIqLMitXg6MCT2yU9/cerccUmosk0i
         Nuqs5foDypOZNlwYVsshygaakt7QDvjlRaoQYp7A=
Date:   Tue, 27 Apr 2021 15:22:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH 150/190] Revert "media: gspca: mt9m111: Check
 write_bridge for timeout"
Message-ID: <YIgQIcBhR4EoPOGM@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-151-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-151-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:25PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 656025850074f5c1ba2e05be37bda57ba2b8d491.
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
>  drivers/media/usb/gspca/m5602/m5602_mt9m111.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/usb/gspca/m5602/m5602_mt9m111.c b/drivers/media/usb/gspca/m5602/m5602_mt9m111.c
> index bfa3b381d8a2..50481dc928d0 100644
> --- a/drivers/media/usb/gspca/m5602/m5602_mt9m111.c
> +++ b/drivers/media/usb/gspca/m5602/m5602_mt9m111.c
> @@ -195,7 +195,7 @@ static const struct v4l2_ctrl_config mt9m111_greenbal_cfg = {
>  int mt9m111_probe(struct sd *sd)
>  {
>  	u8 data[2] = {0x00, 0x00};
> -	int i, rc = 0;
> +	int i;
>  	struct gspca_dev *gspca_dev = (struct gspca_dev *)sd;
>  
>  	if (force_sensor) {
> @@ -213,18 +213,16 @@ int mt9m111_probe(struct sd *sd)
>  	/* Do the preinit */
>  	for (i = 0; i < ARRAY_SIZE(preinit_mt9m111); i++) {
>  		if (preinit_mt9m111[i][0] == BRIDGE) {
> -			rc |= m5602_write_bridge(sd,
> +			m5602_write_bridge(sd,
>  				preinit_mt9m111[i][1],
>  				preinit_mt9m111[i][2]);
>  		} else {
>  			data[0] = preinit_mt9m111[i][2];
>  			data[1] = preinit_mt9m111[i][3];
> -			rc |= m5602_write_sensor(sd,
> +			m5602_write_sensor(sd,
>  				preinit_mt9m111[i][1], data, 2);
>  		}
>  	}
> -	if (rc < 0)
> -		return rc;
>  
>  	if (m5602_read_sensor(sd, MT9M111_SC_CHIPVER, data, 2))
>  		return -ENODEV;
> -- 
> 2.31.1
> 

Same here, OR error values together is not ok, keeping this revert.

greg k-h
