Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACF338C3C7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 11:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbhEUJtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 05:49:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39428 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbhEUJtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 05:49:16 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lk1l2-0005Rc-FH; Fri, 21 May 2021 09:47:52 +0000
Subject: NAK: [PATCH][next] dm space maps: Fix uninitialized variable r2
From:   Colin Ian King <colin.king@canonical.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Joe Thornber <ejt@redhat.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210521094031.42356-1-colin.king@canonical.com>
Message-ID: <fe127847-f8ee-20aa-5613-19b8a110c712@canonical.com>
Date:   Fri, 21 May 2021 10:47:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210521094031.42356-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2021 10:40, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the case where recursing(mm) is true variable r2 is not
> inintialized and an uninitialized value is being used in the
> call combine_errors later on. Fix this by setting r2 to zero.
> 
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: def6a7a9a7f0 ("dm space maps: improve performance with inc/dec on ranges of blocks")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/md/persistent-data/dm-space-map-metadata.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/persistent-data/dm-space-map-metadata.c b/drivers/md/persistent-data/dm-space-map-metadata.c
> index 3b70ee861cf5..5be5ef4c831f 100644
> --- a/drivers/md/persistent-data/dm-space-map-metadata.c
> +++ b/drivers/md/persistent-data/dm-space-map-metadata.c
> @@ -432,9 +432,10 @@ static int sm_metadata_dec_blocks(struct dm_space_map *sm, dm_block_t b, dm_bloc
>  	int32_t nr_allocations;
>  	struct sm_metadata *smm = container_of(sm, struct sm_metadata, sm);
>  
> -	if (recursing(smm))
> +	if (recursing(smm)) {
>  		r = add_bop(smm, BOP_DEC, b, e);
> -	else {
> +		r2 = 0;
> +	} else {
>  		in(smm);
>  		r = sm_ll_dec(&smm->ll, b, e, &nr_allocations);
>  		r2 = out(smm);
> 

There is a another occurrence of this, I'll send a V2 shortly
