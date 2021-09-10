Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A81407216
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 21:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhIJTmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 15:42:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46834 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232951AbhIJTmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 15:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631302899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dImPq1VmXy4K+TXYP1gxl7bI60S9zZxcwcQ5JiLG6kU=;
        b=CcikI4I6SZqMehX/ZJnVa/RS87RbaYNnQgivl67mom/krjnNN5hD9mvKzu9gfoKvs+kRHY
        uXm7LZe2Alg49k93LUJJquWikDhiv+4YXYzLavqUl7kRlcfltyeV0LmfMzp25A7zaEREmi
        TXKH0EkTTqbPBHTtlfmypS3xVGLnacM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-m3gI27N9Pd6RnRpyGiIZYA-1; Fri, 10 Sep 2021 15:41:38 -0400
X-MC-Unique: m3gI27N9Pd6RnRpyGiIZYA-1
Received: by mail-ed1-f72.google.com with SMTP id s15-20020a056402520f00b003cad788f1f6so1483313edd.22
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 12:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dImPq1VmXy4K+TXYP1gxl7bI60S9zZxcwcQ5JiLG6kU=;
        b=PQSN2pj3mHM3l2dFRRt9G1HHH6/rCrAyIpXlNTYobiU2P4dI3kUUuCtuU3BA1uCY+H
         6CMKTtt4rSIFDFtGEwA4p/S7372wtHV4Qvq/7UxNcVQgLBjYR7O2iOV2infNxd4umj+f
         gxEF9kaGUEU5iI23SSSMeUOnv8ygoyZ39VWB+VCGLQ/EE+GLsXHNnLPDv4sznXZCFEXn
         xs0kFel6T3G0O7WxPd/DTd2YpC2BL1FCcQ0qCgDd/FGcO/JIsEUhFKjIorRK2UHX3Elm
         fth5FxNcHte2OEHR1T7w2hda2H939APbwGTHRm7ISN5dXt56vbRDHx3cb239gobu3QvM
         bLLQ==
X-Gm-Message-State: AOAM5315vxwUYBRQfujFqlcGBHTgayEdi9805zbKyCZW+g++LJKOrZcH
        GUKUQm6QvjQYt096W+cQJ0RJiseNR8KGt6hRBM/CfQpriX7xCwIrTBbWIe2lioYsaqrosxpmHE7
        v1D6uHhi1RLBLdA06HEeoAndJ
X-Received: by 2002:a17:906:f43:: with SMTP id h3mr10953839ejj.267.1631302897302;
        Fri, 10 Sep 2021 12:41:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZG+1n3XdCp7FQBd+D4F4iT//2gdDnrW703ukLjgc2Vu0BPDlrdl4n2HcI3bt8ZipRgueWkw==
X-Received: by 2002:a17:906:f43:: with SMTP id h3mr10953831ejj.267.1631302897133;
        Fri, 10 Sep 2021 12:41:37 -0700 (PDT)
Received: from krava ([83.240.60.52])
        by smtp.gmail.com with ESMTPSA id p5sm2795635eju.30.2021.09.10.12.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 12:41:36 -0700 (PDT)
Date:   Fri, 10 Sep 2021 21:41:34 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf tools: Allow build-id with trailing zeros
Message-ID: <YTu07uPsA2/uxvRs@krava>
References: <20210910164150.1028294-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910164150.1028294-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 09:41:50AM -0700, Namhyung Kim wrote:
> Current perf saves a build-id with size but old versions assumes the
> size of 20.  In case the build-id is less than 20 (like for MD5), it'd
> fill the rest with 0s.
> 
> I saw a problem when old version of perf record saved binary in the
> build-id cache and new version of perf reads the data.  The symbols
> should be read from the build-id cache (as the path no longer has the
> same binary) but it failed due to mismatch in the build-id.
> 
>   symsrc__init: build id mismatch for /home/namhyung/.debug/.build-id/53/e4c2f42a4c61a2d632d92a72afa08f00000000/elf.
> 
> The build-id event in the data has 20 byte build-ids, but it saw a
> different size (16) when it reads the build-id of the elf file in the
> build-id cache.
> 
>   $ readelf -n ~/.debug/.build-id/53/e4c2f42a4c61a2d632d92a72afa08f00000000/elf
> 
>   Displaying notes found in: .note.gnu.build-id
>     Owner                Data size 	Description
>     GNU                  0x00000010	NT_GNU_BUILD_ID (unique build ID bitstring)
>       Build ID: 53e4c2f42a4c61a2d632d92a72afa08f
> 
> Let's fix this by allowing trailing zeros if the size is different.
> 
> Fixes: 39be8d0115b3 ("perf tools: Pass build_id object to dso__build_id_equal()")
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/dso.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index ee15db2be2f4..0c0dd877d4e9 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -1349,6 +1349,18 @@ void dso__set_build_id(struct dso *dso, struct build_id *bid)
>  
>  bool dso__build_id_equal(const struct dso *dso, struct build_id *bid)
>  {
> +	static const char zeros[BUILD_ID_SIZE];
> +
> +	if (dso->bid.size > bid->size && dso->bid.size == BUILD_ID_SIZE) {
> +		/*
> +		 * For the backward compatibility, it allows a build-id has
> +		 * trailing zeros.
> +		 */
> +		return !memcmp(dso->bid.data, bid->data, bid->size) &&
> +			!memcmp(&dso->bid.data[bid->size], zeros,
> +				dso->bid.size - bid->size);

we now have memchr_inv in tools, so you could use:
  memchr_inv(&dso->bid.data[bid->size], 0, dso->bid.size - bid->size);

and save 20 bytes in bss ;-) other than that, nice catch

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> +	}
> +
>  	return dso->bid.size == bid->size &&
>  	       memcmp(dso->bid.data, bid->data, dso->bid.size) == 0;
>  }
> -- 
> 2.33.0.309.g3052b89438-goog
> 

