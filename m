Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5A13B9F1D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 12:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhGBKdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 06:33:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22065 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230373AbhGBKdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 06:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625221830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uTz0s4cHmn20J3O6/eToC+IwV2hxla/S4Rdju1MyUOs=;
        b=BJyV2/3Xrtex1p+U2Q5miuJJBfZ+Jqi34EL9pRcWHcX5ni3Ei0wzX2xs9uIELGWjrud06M
        2ZjFe1m2ZaIBctxI2moGcUYBWyXnVXYjqexmw0AmGlOiUicZ3sv+2pneliPNV0PbGDgJCq
        s6hkXtoZRGviJw4E/XL4vuL/DMlBBWw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-E90LcJaJNMWCg8rWdUIlPw-1; Fri, 02 Jul 2021 06:30:29 -0400
X-MC-Unique: E90LcJaJNMWCg8rWdUIlPw-1
Received: by mail-ej1-f71.google.com with SMTP id p5-20020a17090653c5b02903db1cfa514dso3380012ejo.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 03:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uTz0s4cHmn20J3O6/eToC+IwV2hxla/S4Rdju1MyUOs=;
        b=q127X5ne0F+meXCR1518rOL/mhDGXpCslRqIIrxv9Jg/hZ+OHT/vot7Vg4y5LyDaQ+
         pXHttgFpS86OfiI2MTAeesEmsaFmDZwO7dGCCEhhskHKF2jXZhmlGG0vjNdWQiTF4/tH
         XbloXtW6Fj+D1H9i3GbrJM5GoatexlE83ZytVWo2TCHc3E1lJaNseK9nOyE5WdtwWy9U
         wXX7QNiwjZU37HDYZ55FikjAc7l2rycs66nX6GlLPqRaSaWIaJcOB0nSxLVCBFxWja2Z
         03Kn9DiPnIDCdWZFAZLv4LRFWNMYaL6KohMZ7BU75QViiRn4DwRR0VN2HHheqqiDKEzz
         2r+w==
X-Gm-Message-State: AOAM533mAPq4/UfnxfxaLVMV5THNtCZZDyE3shebRiiSbhCJFPjORkab
        qI/NjdUcCjtoGttfMECTsB7Bm+wxqgefg6MHA98YfvGhY+mcD5Y7n7g85i/PCJyp+GbKaeL4Z5C
        2V9qK5Tc9yNfDRrcHI6qP3Aaj
X-Received: by 2002:aa7:c607:: with SMTP id h7mr5787935edq.13.1625221828476;
        Fri, 02 Jul 2021 03:30:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytgyNhf5EbCmNlBJH8vHmzN1gy7V2BZXD1Bgrc3PyjTHrv6T1g/ZKNwTZOYMZjvyQ9xK1bhA==
X-Received: by 2002:aa7:c607:: with SMTP id h7mr5787920edq.13.1625221828301;
        Fri, 02 Jul 2021 03:30:28 -0700 (PDT)
Received: from krava ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id n4sm867333eja.121.2021.07.02.03.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 03:30:27 -0700 (PDT)
Date:   Fri, 2 Jul 2021 12:30:24 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: Re: [PATCH v8 20/22] perf session: Load data directory files for
 analysis
Message-ID: <YN7qwOZ5UlEkZ2zv@krava>
References: <cover.1625065643.git.alexey.v.bayduraev@linux.intel.com>
 <fbcb2de8d7e90cbf418a5a0465f444d0d5295615.1625065643.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbcb2de8d7e90cbf418a5a0465f444d0d5295615.1625065643.git.alexey.v.bayduraev@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 06:54:59PM +0300, Alexey Bayduraev wrote:

SNIP

> +	while ((ret >= 0) && readers) {
> +		if (session_done())
> +			return 0;
> +
> +		if (rd[i].state.eof) {
> +			i = (i + 1) % session->nr_readers;
> +			continue;
> +		}
> +
> +		ret = reader__read_event(&rd[i], session, &prog);
> +		if (ret < 0)
> +			break;
> +		if (ret == READER_EOF) {
> +			ret = reader__mmap(&rd[i], session);
> +			if (ret < 0)
> +				goto out_err;
> +			if (ret == READER_EOF)
> +				readers--;
> +		}
> +
> +		/*
> +		 * Processing 10MBs of data from each reader in sequence,
> +		 * because that's the way the ordered events sorting works
> +		 * most efficiently.
> +		 */
> +		if (rd[i].state.size >= 10*1024*1024) {
> +			rd[i].state.size = 0;
> +			i = (i + 1) % session->nr_readers;
> +		}

hi,
so this was sort of hack to make this faster.. we need some
justification for this and make that configurable as well,
if we keep it

jirka

