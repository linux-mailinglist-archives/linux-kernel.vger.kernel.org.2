Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D684436C9E6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237976AbhD0RA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:00:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238104AbhD0RAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:00:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0B1F6103E;
        Tue, 27 Apr 2021 16:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619542770;
        bh=ESZjsAUmtWYOArzkvA1iWlnH+xFSMHzRBbZXc1L9b/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V6mgrlOe7j3Ngu59gMTNqI0TZUTqghCFLonhJkrAxQkenosDJ+D8oYgKLw1szrjaK
         fiRpQ0aZA+snrPfsa7aIGPrIlKHYYirg2AMKcyzDATAWsj9w/O5I25vSGXO37f2hGL
         4YrPhecRGzhYMLu7hq1gjb20gEQIUELKux17uims=
Date:   Tue, 27 Apr 2021 18:59:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 179/190] Revert "drivers/regulator: fix a missing check
 of return value"
Message-ID: <YIhC8OhnO04EaTMT@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-180-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-180-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:54PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 966e927bf8cc6a44f8b72582a1d6d3ffc73b12ad.
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
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/regulator/palmas-regulator.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
> index 337dd614695e..f27ad8254291 100644
> --- a/drivers/regulator/palmas-regulator.c
> +++ b/drivers/regulator/palmas-regulator.c
> @@ -438,16 +438,13 @@ static int palmas_ldo_write(struct palmas *palmas, unsigned int reg,
>  static int palmas_set_mode_smps(struct regulator_dev *dev, unsigned int mode)
>  {
>  	int id = rdev_get_id(dev);
> -	int ret;
>  	struct palmas_pmic *pmic = rdev_get_drvdata(dev);
>  	struct palmas_pmic_driver_data *ddata = pmic->palmas->pmic_ddata;
>  	struct palmas_regs_info *rinfo = &ddata->palmas_regs_info[id];
>  	unsigned int reg;
>  	bool rail_enable = true;
>  
> -	ret = palmas_smps_read(pmic->palmas, rinfo->ctrl_addr, &reg);
> -	if (ret)
> -		return ret;
> +	palmas_smps_read(pmic->palmas, rinfo->ctrl_addr, &reg);
>  
>  	reg &= ~PALMAS_SMPS12_CTRL_MODE_ACTIVE_MASK;
>  
> -- 
> 2.31.1
> 

Original looks correct, dropping.

greg k-h
