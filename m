Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13B934AFA3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 20:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhCZTxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 15:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhCZTxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 15:53:24 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4990DC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 12:53:24 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id c3so2390089qvz.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 12:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=oaY6dLRTkRuTaTH2Aj9KKt1MDqLb2aW/eMshOkEQwLw=;
        b=aXO6AwPa54ofdfZZShrC2RQZ41xXstCAzPY5MztgTRpLQU4TaxzlA6gy7UoyEuUEPG
         RIkTMOdmaiq73LrIGG2zaQMRm013hfSHEH+SNPrzopPGnxK2dImuTlgtCCPFzJAbIXYz
         rERXvr5PcSI4tfRavdeToorXEdQh6vk9OOxRPeCQUWQwBXoBvliFWnBQ8LkrqESU+MlY
         QQLNr7t8ZoAXhniOP5ibzHWi7daS1dmdQcy4UDqrI3me5ChT7+5rFLJ1w+Wh6WPDOeII
         TJ4jUx4gNn3ggikpu7gV1tIwthkIlQzXqSwTm0l4zXQvPJA6VEJGWNFquGR9YlhOmdqI
         MDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=oaY6dLRTkRuTaTH2Aj9KKt1MDqLb2aW/eMshOkEQwLw=;
        b=kCt4EI/knt6BYQeBa7m957fej2i5U/0R25O2bviAXH1kQHCDJh9WMy1QS9iZU7Is6U
         g5UfDNmbuBXimpyUyRLJhflsq/ULm+71YEG7hDDDHleA4MS1nx5pcvrY184Zw08cFCsU
         Jps7zSc1cRI3CsOiuLlunK9OlaMAyvXthnqWTcrTkyfsItOSDOKzHX2C7aaHPDVkCKnm
         jtjkOi1cPVNf3PPXZZv1cdFwkvMa+RzMF9BqrHmg1Zy4vZycw1i6YvNn1J7o3/XU7Ahm
         7XGJri912yU4FQNWYfgtWSLW19Rkvzo1FsMndWFBJDJZHhkVJHpFu64SZ8cmZv9WVgs0
         Srkw==
X-Gm-Message-State: AOAM5329U/RQlzN4DC8aIhwS1CtzHJS0etYfjMj6maXseQ8BDl/nOb5g
        3HjH3AqTUXoxFlQmQTMn2Wk=
X-Google-Smtp-Source: ABdhPJw07Pd/+bd28eldCN4Fe9ekBwu3c6wGIEU8tS5vsvx3LBNlx7f8OiN5u+00VLqGj1ztmG9ubQ==
X-Received: by 2002:ad4:4745:: with SMTP id c5mr15019637qvx.39.1616788402231;
        Fri, 26 Mar 2021 12:53:22 -0700 (PDT)
Received: from Gentoo ([156.146.58.30])
        by smtp.gmail.com with ESMTPSA id b22sm7579245qkk.45.2021.03.26.12.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 12:53:21 -0700 (PDT)
Date:   Sat, 27 Mar 2021 01:23:11 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     suzuki.poulose@arm.com, leo.yan@linaro.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] coresight-pmu.h: Fix a typo
Message-ID: <YF47p68yNRgIpuQU@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        suzuki.poulose@arm.com, leo.yan@linaro.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
References: <20210326142244.17504-1-unixbhaskar@gmail.com>
 <20210326153213.GA2009902@xps15>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EkrQbERT0zqxOKmN"
Content-Disposition: inline
In-Reply-To: <20210326153213.GA2009902@xps15>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EkrQbERT0zqxOKmN
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 09:32 Fri 26 Mar 2021, Mathieu Poirier wrote:
>Hi Bhaskar,
>
>On Fri, Mar 26, 2021 at 07:52:44PM +0530, Bhaskar Chowdhury wrote:
>>
>> s/orignally/originally/
>
>Even if the change is trivial this changelog is insufficient.  Moreover, if you
>found the problem with an automated tool, please add the name of the tool to the
>changelog.
>
Oh Hi!

I think the changelog is sufficient enough to conveying the triviality of this
change.What's the point of writing unnecessary history , when a simple
statement can do the work.

These are hand picked ...there is no point mentioning the tool in the
changelog..it is all age old UNIX/Linux tool , nothing special.

>Thanks,
>Mathieu
>
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  include/linux/coresight-pmu.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
>> index 4ac5c081af93..2d5c29e3cb8a 100644
>> --- a/include/linux/coresight-pmu.h
>> +++ b/include/linux/coresight-pmu.h
>> @@ -14,7 +14,7 @@
>>   * Below are the definition of bit offsets for perf option, and works as
>>   * arbitrary values for all ETM versions.
>>   *
>> - * Most of them are orignally from ETMv3.5/PTM's ETMCR config, therefore,
>> + * Most of them are originally from ETMv3.5/PTM's ETMCR config, therefore,
>>   * ETMv3.5/PTM doesn't define ETMCR config bits with prefix "ETM3_" and
>>   * directly use below macros as config bits.
>>   */
>> --
>> 2.26.2
>>

--EkrQbERT0zqxOKmN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBeO6cACgkQsjqdtxFL
KRXMqggAgNSlQ5vtMqxUC1Hh5+RVn+V4BN/kzvaZlY4k7buVXSmNxtwq6rxf6qIU
R5F53NaqsA6TN5uPiQssc9CN+petoW5avXbZMN05twBRJ4bpODfYDX2lAPnC/XGJ
HEI0A41C+gPDnKIk4pl9xVaOASFTZ3s4CmeN3jkToKkhwsQeB6PxbnH99eYpLwrs
ALiOZkg2bp7k1ZxVU3dBvlNIEGsM120pE5SDrI4icZFZmJD3RQIPdKewATvBxiUp
V/83i1eiJ/ABNYicmd6TquarMY0EwJNCgo+Wy7fTtqfBduwWzYHKL3ybl+zrdzi5
8qsqytCZH3rFIeaBlkCl/AWhvyDxTA==
=f26s
-----END PGP SIGNATURE-----

--EkrQbERT0zqxOKmN--
