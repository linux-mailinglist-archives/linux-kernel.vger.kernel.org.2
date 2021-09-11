Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466E1407A32
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 21:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbhIKTGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 15:06:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233408AbhIKTGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 15:06:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84CBF611AD;
        Sat, 11 Sep 2021 19:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631387124;
        bh=Z5FqEsUSnA0ZgDY/B/qAixPviz+O6lc9d++hz7Bgefc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DyIYu+/LKDePkTZrUyPW02rmsYbZ0EXmtNp49yqIxOi4zXxFXpNGNZiuN/zT6qqGq
         ZdKArArNmWK318Nb64p2khoz6eZ/LdutQIQfFIrXey0YKu+3T/qZLENDmBBHc68gmD
         ddbwqsy4iNs1p1xVxbBnLf0gs0yZLZDUy84DA6H8KxhxVXbqvVgUoyQJLNG1sACWB6
         yk7jPSc9OmQt1AVBBHeWmS6pJcM0aEcyVknYa55yE5KxoCO5p+LnTE4G1ZTdTHEBk7
         TAw0n5wCTmG3GFRZy9ySn/hPgqxPEP0F7Bdm4aQo+8TuUBViV7az11hHVr0o7I/w3y
         wR6YFOlMNDp1A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 029C54038F; Sat, 11 Sep 2021 16:05:21 -0300 (-03)
Date:   Sat, 11 Sep 2021 16:05:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2] perf tools: Allow build-id with trailing zeros
Message-ID: <YTz98YhhCAm41nlp@kernel.org>
References: <20210910224630.1084877-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910224630.1084877-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 10, 2021 at 03:46:30PM -0700, Namhyung Kim escreveu:
> Current perf saves a build-id with size but old versions assumes the
> size of 20.  In case the build-id is less than 20 (like for MD5), it'd
> fill the rest with 0s.

Thanks, applied.

- Arnaldo

 
> I saw a problem when old version of perf record saved a binary in the
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
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/dso.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index ee15db2be2f4..9ed9a5676d35 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -1349,6 +1349,16 @@ void dso__set_build_id(struct dso *dso, struct build_id *bid)
>  
>  bool dso__build_id_equal(const struct dso *dso, struct build_id *bid)
>  {
> +	if (dso->bid.size > bid->size && dso->bid.size == BUILD_ID_SIZE) {
> +		/*
> +		 * For the backward compatibility, it allows a build-id has
> +		 * trailing zeros.
> +		 */
> +		return !memcmp(dso->bid.data, bid->data, bid->size) &&
> +			!memchr_inv(&dso->bid.data[bid->size], 0,
> +				    dso->bid.size - bid->size);
> +	}
> +
>  	return dso->bid.size == bid->size &&
>  	       memcmp(dso->bid.data, bid->data, dso->bid.size) == 0;
>  }
> -- 
> 2.33.0.309.g3052b89438-goog

-- 

- Arnaldo
