Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49482398845
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhFBL1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:27:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2568 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232850AbhFBL05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:26:57 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 152BCMWE000946;
        Wed, 2 Jun 2021 11:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=boB/nKh+qAxdwe2vTp/6XFb++1c2+Zuxo/FZb24bAlo=;
 b=LQWlcG9VMFyUiywqjQcY/S0NBRjC+Ewy8jp2QfZ2qR9rIe/GtWztjycbjroQ5UstOktV
 WfuVSbDTjJIpZduvMLFM7W9M9vTZ6APHuUAulygv2Z+PVUt0lcTsmWj2rFf9gfpppBiT
 wc65BQ2ICIKvK3ZQDGouZGYT05505MHHEr2d/e33iy7M1ijLvWnY/18dZKjYRxGZ8eO9
 ykTTMHn+WDFGxeRj+HjsvDRUluqQl0BrwSu8CWLFtQCTDBqKcUvgXdz456uTXu/g9+aq
 gEhItMZT1Ethlzg/2kfVf9AMaG7kdChWbZ1r0oAjRSSDueK1CfpATI3IP6mQXDBPG1ys uA== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38wr508b0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Jun 2021 11:24:32 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 152BKCm5114181;
        Wed, 2 Jun 2021 11:24:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38x1bcuk35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Jun 2021 11:24:31 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 152BOV0R120478;
        Wed, 2 Jun 2021 11:24:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 38x1bcuk22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Jun 2021 11:24:31 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 152BORDh008252;
        Wed, 2 Jun 2021 11:24:27 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Jun 2021 11:24:26 +0000
Date:   Wed, 2 Jun 2021 14:24:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Lee Jones <lee.jones@linaro.org>, alsa-devel@alsa-project.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: rk817: remove redundant assignment to
 pointer node
Message-ID: <20210602112416.GG1955@kadam>
References: <20210602102746.11793-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602102746.11793-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: Omvj3_IJRJvZEPF87IJzLnvGmWx-Uk1T
X-Proofpoint-GUID: Omvj3_IJRJvZEPF87IJzLnvGmWx-Uk1T
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 11:27:46AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pointer node is being initialized with a value that is never read and
> it is being updated later with a new value.  The initialization is
> redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  sound/soc/codecs/rk817_codec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/rk817_codec.c b/sound/soc/codecs/rk817_codec.c
> index 17e672b85ee5..0d7cc26ded57 100644
> --- a/sound/soc/codecs/rk817_codec.c
> +++ b/sound/soc/codecs/rk817_codec.c
> @@ -457,7 +457,7 @@ static const struct snd_soc_component_driver soc_codec_dev_rk817 = {
>  static void rk817_codec_parse_dt_property(struct device *dev,
>  					 struct rk817_codec_priv *rk817)
>  {
> -	struct device_node *node = dev->parent->of_node;
> +	struct device_node *node;
>  
>  	node = of_get_child_by_name(dev->parent->of_node, "codec");
>  	if (!node) {

This function needs an of_node_put().

regards,
dan carpenter

