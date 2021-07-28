Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A34E3D995C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 01:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbhG1XRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 19:17:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43361 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232143AbhG1XRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 19:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627514267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yPDkVTZ8b83r4TbJSlWFDW+2FFM5TXW1fN7erbN+dQI=;
        b=QKjnYiJ4L/maPqH48n3cgD+eV9RaYiwTsr/YRqwsd07vc//REuJGxped/M0pfGpWRj8mfe
        979lq+OqG7cxMliZebhh4oDwn5URX23AS1jjPyoH3Ks+IOKycwACTtc7LmmJpDd17bEd2h
        WyN0cv7ys4kfy2soiJdMLsxEquQBwxg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-N5kzZc4QMO6cLNZr8owk9w-1; Wed, 28 Jul 2021 19:17:46 -0400
X-MC-Unique: N5kzZc4QMO6cLNZr8owk9w-1
Received: by mail-qt1-f198.google.com with SMTP id o7-20020ac87c470000b029025f8084df09so1847407qtv.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 16:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yPDkVTZ8b83r4TbJSlWFDW+2FFM5TXW1fN7erbN+dQI=;
        b=tkHWssqrsKyiEuiVcBa77fNKrxt/E3kfHFRwH7PsqQl7mNRTRL4ml4mUR5d8zMRUva
         szVPwQDlxpzSHlhxbpxxaI4+2FIS2UZht4X+VSFKKfcvkmCBQduGGEBg610Xc8zEujpg
         GJJuXxrZoz0HpqcOCF5fs08LmVviiYQgWZLlNSnTT7Y0dHK8aW9GFR0/LAcNZxBp643N
         Coi+Wyz25ptgFZLY+yURlj1LIFTWcHjdQNpP7hw3XBZ6yYXwdS3AbVTGGGWfDRsN8sLW
         ceSCGFh+JEGWY0dGFyilPrgiLoAqKt7WN/CReqrd2MSFtT9sMHS3Q6BHSMv5kfHaj7Ch
         VTrw==
X-Gm-Message-State: AOAM531Zo9Ag3KC708MuMYAVPIj7TwMYw/PUPrla+mGBO7MskY6yx4Ww
        FEAKgz+rh1LpmbmsR/Cecq6gD0MfLQ2FeSasyPokdak2gMTAlwEsz5e72KNz0S822rveoRQwoNg
        G/67wnOXsb0ZUhwHYIWs0PVqrimI/p7XoLn63eCZUosXqMpPPN20LeUbxZ1TqfZMvdQZ2raA=
X-Received: by 2002:a37:b0a:: with SMTP id 10mr2186646qkl.291.1627514266176;
        Wed, 28 Jul 2021 16:17:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXAgP9lkJWoLrU3pYzWQ9f0mbAUQ4I6TKaLd4nsL8jBdRO7aVFQFKVPcznO0D3SmBXEvMXYQ==
X-Received: by 2002:a37:b0a:: with SMTP id 10mr2186621qkl.291.1627514265949;
        Wed, 28 Jul 2021 16:17:45 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q184sm794947qkd.35.2021.07.28.16.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 16:17:45 -0700 (PDT)
Subject: Re: [PATCH] fpga: Fix spelling mistake "eXchnage" -> "exchange" in
 Kconfig
To:     Colin King <colin.king@canonical.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210728215150.191914-1-colin.king@canonical.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <5e7b2e4a-aaf6-81f2-2b08-5a9adcbbee57@redhat.com>
Date:   Wed, 28 Jul 2021 16:17:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210728215150.191914-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/28/21 2:51 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in the Kconfig text. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/fpga/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 16793bfc2bb4..991b3f361ec9 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -119,7 +119,7 @@ config XILINX_PR_DECOUPLER
>   	depends on HAS_IOMEM
>   	help
>   	  Say Y to enable drivers for Xilinx LogiCORE PR Decoupler
> -	  or Xilinx Dynamic Function eXchnage AIX Shutdown Manager.
> +	  or Xilinx Dynamic Function eXchange AIX Shutdown Manager.
>   	  The PR Decoupler exists in the FPGA fabric to isolate one
>   	  region of the FPGA from the busses while that region is
>   	  being reprogrammed during partial reconfig.

Looks good, thanks

Reviewed-by: Tom Rix <trix@redhat.com>

