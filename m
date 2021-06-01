Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66CA7396D61
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 08:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbhFAGfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 02:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbhFAGf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 02:35:29 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7671C061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 23:33:48 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id u7so6331237plq.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 23:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gzoyNfI33rDasUSzvHTR4JxSN7Yi8Ec1jO1hc1RieLc=;
        b=GszxXFRLfHQ/fLCRyYVZc1z6y1FVSkRujtpGcbprBDB3syL/7VPkzoK696UtQyCFMn
         +vBb1gZE89f/2kSVruS0syoUQEZueGNbOXIqyUufi/USGl0NlkMwmj+z2v0ZwcDVqln5
         XfV8PBn+j5HYgH90eQShWC40mfrnaZB8T2ECc6vBRfK3O7DcmGv5p1k5DgGrWFC74jGL
         xlwrOPZupVM9ErKinJ9wJXqR1G6g2Y4sIuEdaR1iZeQyUWY7Q5Z/1yc5oKr/N4qAfF6E
         KJZpDDB7T3QFl4tz3eiyzIeREgBPCvo5sjWPjbIq1WtNrPsJl4TMe3Z6Kbp95d9w11OJ
         pQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gzoyNfI33rDasUSzvHTR4JxSN7Yi8Ec1jO1hc1RieLc=;
        b=MeTGD5YfaC6hR4Vkt48SvFZw8Ge/ugC+3jL8YS3t7+0GEfG5YQk0EUqXTQjGGjV1Hl
         JI0u9AFVbeQkhKKw3bePAk/r6GS56blUus5AxRqqmOBkJk5zBPCJ2pJ3qQrE1otg7QSw
         x8EW9E/B2cLl0iT1Pn2ePm3CXYv4VGlQpCGqHtfW2XRDUE2nVNPuCRCp4IOBddwyy8PX
         h7929KDXvxlJoa2GbU89gxnt0H/YrRfNJLuYKXkYCuMDeDpjM/AzV3zwtX/kQkyU4T/k
         oD2NzItoZ2hptLcsDdRIYrVHdjrH9qNg74dQWZUEYfjibm8wofRzre2iTJ4VgmIQ8Obz
         6pqg==
X-Gm-Message-State: AOAM533Sh5azOmsZaFehiOC9nrF8C9nvoYaaVTLrMTP85rlfcPJBanSq
        AstvApgSqlldy9tCa/0Qz0Upwg==
X-Google-Smtp-Source: ABdhPJxND31+qWMs2rp1ZsFFHjjp42w48iqG0/aEummHz26IdKwOHGQIyXj8Fvm7nTVLapW3glXv9A==
X-Received: by 2002:a17:90b:689:: with SMTP id m9mr3268826pjz.102.1622529228241;
        Mon, 31 May 2021 23:33:48 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id h6sm12562224pjs.15.2021.05.31.23.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 23:33:47 -0700 (PDT)
Date:   Tue, 1 Jun 2021 14:33:42 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] perf auxtrace: Optimize barriers with
 load-acquire and store-release
Message-ID: <20210601063342.GB10026@leoy-ThinkPad-X240s>
References: <20210519140319.1673043-1-leo.yan@linaro.org>
 <20210519140319.1673043-2-leo.yan@linaro.org>
 <20210531151049.GE9324@leoy-ThinkPad-X240s>
 <cc3810cd-5edc-26d3-9c77-8bb6479152c1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc3810cd-5edc-26d3-9c77-8bb6479152c1@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 10:03:33PM +0300, Adrian Hunter wrote:
> On 31/05/21 6:10 pm, Leo Yan wrote:
> > Hi Peter, Adrian,
> > 
> > On Wed, May 19, 2021 at 10:03:19PM +0800, Leo Yan wrote:
> >> Load-acquire and store-release are one-way permeable barriers, which can
> >> be used to guarantee the memory ordering between accessing the buffer
> >> data and the buffer's head / tail.
> >>
> >> This patch optimizes the memory ordering with the load-acquire and
> >> store-release barriers.
> > 
> > Is this patch okay for you?
> > 
> > Besides this patch, I have an extra question.  You could see for
> > accessing the AUX buffer's head and tail, it also support to use
> > compiler build-in functions for atomicity accessing:
> > 
> >   __sync_val_compare_and_swap()
> >   __sync_bool_compare_and_swap()
> > 
> > Since now we have READ_ONCE()/WRITE_ONCE(), do you think we still need
> > to support __sync_xxx_compare_and_swap() atomicity?
> 
> I don't remember, but it seems to me atomicity is needed only
> for a 32-bit perf running with a 64-bit kernel.

32-bit perf wants to access 64-bit value atomically, I think it tries to
avoid the issue caused by scenario:

        CPU0 (64-bit kernel)           CPU1 (32-bit user)

                                         read head_lo
        WRITE_ONCE(head)
                                         read head_hi


I dumped the disassembly for reading 64-bit value for perf Arm32 and get
below results:

  perf Arm32 for READ_ONCE():

	case 8: *(__u64_alias_t *) res = *(volatile __u64_alias_t *) p; break;
     84a:	68fb      	ldr	r3, [r7, #12]
     84c:	e9d3 2300 	ldrd	r2, r3, [r3]
     850:	6939      	ldr	r1, [r7, #16]
     852:	e9c1 2300 	strd	r2, r3, [r1]
     856:	e007      	b.n	868 <auxtrace_mmap__read_head+0xb0>

It uses the instruction ldrd which is "Load Register Dual (register)",
but this doesn't mean the instruction is atomic, especially based on
the comment in the kernel header include/asm-generic/rwonce.h, I think
the instruction ldrd/strd will be "atomic in some cases (namely Armv7 +
LPAE), but for others we rely on the access being split into 2x32-bit
accesses".


  perf Arm32 for __sync_val_compare_and_swap():

	u64 head = __sync_val_compare_and_swap(&pc->aux_head, 0, 0);
     7d6:	68fb      	ldr	r3, [r7, #12]
     7d8:	f503 6484 	add.w	r4, r3, #1056	; 0x420
     7dc:	f04f 0000 	mov.w	r0, #0
     7e0:	f04f 0100 	mov.w	r1, #0
     7e4:	f3bf 8f5b 	dmb	ish
     7e8:	e8d4 237f 	ldrexd	r2, r3, [r4]
     7ec:	ea52 0c03 	orrs.w	ip, r2, r3
     7f0:	d106      	bne.n	800 <auxtrace_mmap__read_head+0x48>
     7f2:	e8c4 017c 	strexd	ip, r0, r1, [r4]
     7f6:	f1bc 0f00 	cmp.w	ip, #0
     7fa:	f1bc 0f00 	cmp.w	ip, #0
     7fe:	d1f3      	bne.n	7e8 <auxtrace_mmap__read_head+0x30>
     800:	f3bf 8f5b 	dmb	ish
     804:	e9c7 2304 	strd	r2, r3, [r7, #16]

For __sync_val_compare_and_swap(), it uses the instructions
ldrexd/ldrexd, these two instructions rely on the exclusive monitor
for accessing 64-bit value, so seems to me this is more reliable way
for accessing 64-bit value in CPU's 32-bit mode.

Conclusion: seems to me __sync_xxx_compare_and_swap() should be kept
in this case rather than using READ_ONCE() for 32-bit building.  Or
any other suggestions?  Thanks!

Leo
