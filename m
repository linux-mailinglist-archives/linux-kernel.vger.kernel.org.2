Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472C2347ABE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 15:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbhCXOcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 10:32:23 -0400
Received: from smtprelay0227.hostedemail.com ([216.40.44.227]:47958 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236330AbhCXOcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 10:32:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 32F09182244EB;
        Wed, 24 Mar 2021 14:32:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3865:3867:3868:3870:3871:3872:3874:4321:4605:5007:6119:6120:7576:7652:7901:7903:8603:10004:10400:11026:11232:11473:11657:11658:11783:11914:12043:12048:12297:12438:12555:12683:12740:12895:13439:13894:14181:14659:14721:21080:21433:21451:21627:21660:21972:21990:30046:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: hill42_1e033b52777b
X-Filterd-Recvd-Size: 4973
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Wed, 24 Mar 2021 14:31:59 +0000 (UTC)
Message-ID: <382fd12d804ac8e2693f92cf649c4f038f9c022e.camel@perches.com>
Subject: Re: [PATCH] amdgpu: fix gcc -Wrestrict warning
From:   Joe Perches <joe@perches.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huang Rui <ray.huang@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Wed, 24 Mar 2021 07:31:58 -0700
In-Reply-To: <20210323130430.2250052-1-arnd@kernel.org>
References: <20210323130430.2250052-1-arnd@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-03-23 at 14:04 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc warns about an sprintf() that uses the same buffer as source
> and destination, which is undefined behavior in C99:
> 
> drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c: In function 'amdgpu_securedisplay_debugfs_write':
> drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c:141:6: error: 'sprintf' argument 3 overlaps destination object 'i2c_output' [-Werror=restrict]
>   141 |      sprintf(i2c_output, "%s 0x%X", i2c_output,
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   142 |       securedisplay_cmd->securedisplay_out_message.send_roi_crc.i2c_buf[i]);
>       |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c:97:7: note: destination object referenced by 'restrict'-qualified argument 1 was declared here
>    97 |  char i2c_output[256];
>       |       ^~~~~~~~~~
> 
> Rewrite it to remember the current offset into the buffer instead.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> index 834440ab9ff7..69d7f6bff5d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> @@ -136,9 +136,10 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
>  		ret = psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
>  		if (!ret) {
>  			if (securedisplay_cmd->status == TA_SECUREDISPLAY_STATUS__SUCCESS) {
> +				int pos = 0;
>  				memset(i2c_output,  0, sizeof(i2c_output));
>  				for (i = 0; i < TA_SECUREDISPLAY_I2C_BUFFER_SIZE; i++)
> -					sprintf(i2c_output, "%s 0x%X", i2c_output,
> +					pos += sprintf(i2c_output + pos, " 0x%X",
>  						securedisplay_cmd->securedisplay_out_message.send_roi_crc.i2c_buf[i]);
>  				dev_info(adev->dev, "SECUREDISPLAY: I2C buffer out put is :%s\n", i2c_output);

Perhaps use a hex output like:

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
index 9cf856c94f94..25bb34c72d20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
@@ -97,13 +97,12 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
 	uint32_t op;
 	int i;
 	char str[64];
-	char i2c_output[256];
 	int ret;
 
 	if (*pos || size > sizeof(str) - 1)
 		return -EINVAL;
 
-	memset(str,  0, sizeof(str));
+	memset(str, 0, sizeof(str));
 	ret = copy_from_user(str, buf, size);
 	if (ret)
 		return -EFAULT;
@@ -139,11 +138,9 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
 		ret = psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
 		if (!ret) {
 			if (securedisplay_cmd->status == TA_SECUREDISPLAY_STATUS__SUCCESS) {
-				memset(i2c_output,  0, sizeof(i2c_output));
-				for (i = 0; i < TA_SECUREDISPLAY_I2C_BUFFER_SIZE; i++)
-					sprintf(i2c_output, "%s 0x%X", i2c_output,
-						securedisplay_cmd->securedisplay_out_message.send_roi_crc.i2c_buf[i]);
-				dev_info(adev->dev, "SECUREDISPLAY: I2C buffer out put is :%s\n", i2c_output);
+				dev_info(adev->dev, "SECUREDISPLAY: I2C buffer output is: %*ph\n",
+					 (int)TA_SECUREDISPLAY_I2C_BUFFER_SIZE,
+					 securedisplay_cmd->securedisplay_out_message.send_roi_crc.i2c_buf);
 			} else {
 				psp_securedisplay_parse_resp_status(psp, securedisplay_cmd->status);
 			}


