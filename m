Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627F330CBF1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239991AbhBBTkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239859AbhBBTjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 14:39:37 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DB0C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 11:38:55 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id n14so8796117iog.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 11:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=15xzxOKn9iSL4CBlSeR8HbWOneHOkSrH5EzHzaqZcH8=;
        b=ILpTYTQ4WOFfVc3J8ujtp9O1L9bkB6FU2EMUf/drzOk4c9vQBgtV8CFxmFzdqGFTJS
         jKXoOSPwbgYXlsBAVfnf8jQHEWAUIstm48FPPd7rH74h0GOM+q12foS2Qri2bB7BcPtO
         fgjNmQqzoUR+yhYGe7+AT9075jJd1AqLzDXLDV4MLA68AhOSa+Dymnt5JtmjnIsVj+oB
         Awby5udbmgsiqFPuN2o1CjMGoXvyQq25MU7l035wGLC6OImYUh3A6eKgYVF2E1Sn9kx5
         JU5cgtcsmVLyeh4t67LIysv2NmXxji3ZlZW6CBNiStCmMkIdwXGoRSdOo1k79sOCsocK
         mADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=15xzxOKn9iSL4CBlSeR8HbWOneHOkSrH5EzHzaqZcH8=;
        b=YgoyccqbruO1TKtPJSGcJplFeMD55AgCjKOQbu0pHOtlBiLWk0Lnkvow9/u6xh3nj9
         THofmDuMxe4inqrD3G7gLeJJzwjclGiU/fZy8gB8pUjyBlsNjMt42JJYa0Tw7w4t3uXq
         Gp+lVouyRsI5EicSKsKgDLW/UZpsGAPwvn6aWUZp4DX+e/tiDRpd7+VpzrNkkT/a2yjF
         ib4YB1xk9TK2QlUSI5KLKtaSOWqBqggWv5AjuQxeb9xcxtlpySdWfovqwbHcXsdK/OGi
         CV2pUluGOeBZ4MQcqCYsCyYIvVwG1ycYgH3QNBAVHwlFEHQgXhTzYWogO+2+fYZiphmA
         E5Cg==
X-Gm-Message-State: AOAM530BZo1fe8s7zO2bKuImEPs9MXi/X/3zKlyv7O3c4RtdgAwm+4om
        sbk7mJaBopSVv7u/+kcVEIKbGA==
X-Google-Smtp-Source: ABdhPJxtRky+Jq7VjwKkRVDxVdQiLG15nu8eLG8DAd+9lShB2KQySlNWPZBLZubaBpybssxBcnssDQ==
X-Received: by 2002:a02:cd37:: with SMTP id h23mr12713125jaq.29.1612294734176;
        Tue, 02 Feb 2021 11:38:54 -0800 (PST)
Received: from google.com ([2620:15c:183:200:78f9:6386:be80:e7fc])
        by smtp.gmail.com with ESMTPSA id u17sm3994750ioc.23.2021.02.02.11.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 11:38:53 -0800 (PST)
Date:   Tue, 2 Feb 2021 12:38:49 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        page-reclaim@google.com
Subject: Re: Augmented Page Reclaim
Message-ID: <YBmqSegMq8GWPGCf@google.com>
References: <YBkT6175GmMWBvw3@google.com>
 <20210202121708.GT308988@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dl73G/axgAFsWD6w"
Content-Disposition: inline
In-Reply-To: <20210202121708.GT308988@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dl73G/axgAFsWD6w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 02, 2021 at 12:17:08PM +0000, Matthew Wilcox wrote:
> 
> It's hard to know which 'note' refers to which reference.  Here's
> my attempt to figure that out.

Sorry for the trouble. [note]_ links to

.. [note] See ``Documentation/vm/multigen-lru.rst`` in the tree.

which has nothing to do with the references listed at the bottom.

The references are helpful but not required to process the information
in this email or the doc above.

Let me attach PDF files generated my first email (intro.pdf) and the
doc (man.pdf). They are better formatted.

> 
> On Tue, Feb 02, 2021 at 01:57:15AM -0700, Yu Zhao wrote:
> 
> > Versatility
> > ===========
> > Userspace can trigger aging and eviction independently via the
> > ``debugfs`` interface [note]_ for working set estimation, proactive
> 
> 1. `Long-term SLOs for reclaimed cloud computing resources
>    <https://research.google/pubs/pub43017/>`_
> 
> > reclaim, far memory tiering, NUMA-aware job scheduling, etc. The
> > metrics from the interface are easily interpretable, which allows
> > intuitive provisioning and discoveries like the Borg example above.
> > For a warehouse-scale computer, the interface is intended to be a
> > building block of a closed-loop control system, with a machine
> > learning algorithm being the controller.
> > 
> > Simplicity
> > ==========
> > The workflow [note]_ is well defined and each step in it has a clear
> 
> 2. `Profiling a warehouse-scale computer
>    <https://research.google/pubs/pub44271/>`_
> 
> > meaning. There are no magic numbers or heuristics involved but a few
> > basic data structures that have negligible memory footprint. This
> > simplicity has served us well as the scale and the diversity of our
> > workloads constantly grow.
> [...]
> > FAQ
> > ===
> > What is the motivation for this work?
> > -------------------------------------
> > In our case, DRAM is a major factor in total cost of ownership, and
> > improving memory overcommit brings a high return on investment.
> > Moreover, Google-Wide Profiling has been observing the high CPU
> > overhead [note]_ from page reclaim.
> 
> 3. `Evaluation of NUMA-Aware Scheduling in Warehouse-Scale Clusters
>    <https://research.google/pubs/pub48329/>`_
> 
> > Why not try to improve the existing code?
> > -----------------------------------------
> > We have tried but concluded the two limiting factors [note]_ in the
> 
> 4. `Software-defined far memory in warehouse-scale computers
>    <https://research.google/pubs/pub48551/>`_
> 
> > existing code are fundamental, and therefore changes made atop them
> > will not result in substantial gains on any of the aspects above.
> > 
> > What particular workloads does it help?
> > ---------------------------------------
> > This work optimizes page reclaim for workloads that are not IO bound,
> > because we find they are the norm on servers and clients in the cloud
> > era. It would most likely help any workloads that share the common
> > characteristics [note]_ we observed.
> 
> 5. `Borg: the Next Generation
>    <https://research.google/pubs/pub49065/>`_
> 

--dl73G/axgAFsWD6w
Content-Type: application/pdf
Content-Disposition: attachment; filename="intro.pdf"
Content-Transfer-Encoding: quoted-printable

%PDF-1.4=0A%=93=8C=8B=9E ReportLab Generated PDF document http://www.report=
lab.com=0A1 0 obj=0A<<=0A/F1 2 0 R /F2 3 0 R /F3 4 0 R /F4 6 0 R=0A>>=0Aend=
obj=0A2 0 obj=0A<<=0A/BaseFont /Helvetica /Encoding /WinAnsiEncoding /Name =
/F1 /Subtype /Type1 /Type /Font=0A>>=0Aendobj=0A3 0 obj=0A<<=0A/BaseFont /H=
elvetica-Bold /Encoding /WinAnsiEncoding /Name /F2 /Subtype /Type1 /Type /F=
ont=0A>>=0Aendobj=0A4 0 obj=0A<<=0A/BaseFont /Courier /Encoding /WinAnsiEnc=
oding /Name /F3 /Subtype /Type1 /Type /Font=0A>>=0Aendobj=0A5 0 obj=0A<<=0A=
/Contents 32 0 R /MediaBox [ 0 0 595.2756 841.8898 ] /Parent 31 0 R /Resour=
ces <<=0A/Font 1 0 R /ProcSet [ /PDF /Text /ImageB /ImageC /ImageI ]=0A>> /=
Rotate 0 /Trans <<=0A=0A>> =0A  /Type /Page=0A>>=0Aendobj=0A6 0 obj=0A<<=0A=
/BaseFont /Helvetica-BoldOblique /Encoding /WinAnsiEncoding /Name /F4 /Subt=
ype /Type1 /Type /Font=0A>>=0Aendobj=0A7 0 obj=0A<<=0A/Contents 33 0 R /Med=
iaBox [ 0 0 595.2756 841.8898 ] /Parent 31 0 R /Resources <<=0A/Font 1 0 R =
/ProcSet [ /PDF /Text /ImageB /ImageC /ImageI ]=0A>> /Rotate 0 /Trans <<=0A=
=0A>> =0A  /Type /Page=0A>>=0Aendobj=0A8 0 obj=0A<<=0A/Contents 34 0 R /Med=
iaBox [ 0 0 595.2756 841.8898 ] /Parent 31 0 R /Resources <<=0A/Font 1 0 R =
/ProcSet [ /PDF /Text /ImageB /ImageC /ImageI ]=0A>> /Rotate 0 /Trans <<=0A=
=0A>> =0A  /Type /Page=0A>>=0Aendobj=0A9 0 obj=0A<<=0A/Outlines 11 0 R /Pag=
eLabels 35 0 R /PageMode /UseNone /Pages 31 0 R /Type /Catalog=0A>>=0Aendob=
j=0A10 0 obj=0A<<=0A/Author () /CreationDate (D:20210121175546+00'00') /Cre=
ator (\(unspecified\)) /Keywords () /ModDate (D:20210121175546+00'00') /Pro=
ducer (ReportLab PDF Library - www.reportlab.com) =0A  /Subject (\(unspecif=
ied\)) /Title (Multigenerational LRU) /Trapped /False=0A>>=0Aendobj=0A11 0 =
obj=0A<<=0A/Count 25 /First 12 0 R /Last 27 0 R /Type /Outlines=0A>>=0Aendo=
bj=0A12 0 obj=0A<<=0A/Count 3 /Dest [ 5 0 R /XYZ 62.69291 729.0236 0 ] /Fir=
st 13 0 R /Last 15 0 R /Next 16 0 R /Parent 11 0 R =0A  /Title (Quick start=
)=0A>>=0Aendobj=0A13 0 obj=0A<<=0A/Dest [ 5 0 R /XYZ 62.69291 696.0236 0 ] =
/Next 14 0 R /Parent 12 0 R /Title (Build options)=0A>>=0Aendobj=0A14 0 obj=
=0A<<=0A/Dest [ 5 0 R /XYZ 62.69291 597.0236 0 ] /Next 15 0 R /Parent 12 0 =
R /Prev 13 0 R /Title (Runtime options)=0A>>=0Aendobj=0A15 0 obj=0A<<=0A/De=
st [ 5 0 R /XYZ 62.69291 372.8236 0 ] /Parent 12 0 R /Prev 14 0 R /Title (R=
ecipes)=0A>>=0Aendobj=0A16 0 obj=0A<<=0A/Count 2 /Dest [ 7 0 R /XYZ 62.6929=
1 765.0236 0 ] /First 17 0 R /Last 18 0 R /Next 19 0 R /Parent 11 0 R =0A  =
/Prev 12 0 R /Title (Workflow)=0A>>=0Aendobj=0A17 0 obj=0A<<=0A/Dest [ 7 0 =
R /XYZ 62.69291 618.0236 0 ] /Next 18 0 R /Parent 16 0 R /Title (Aging)=0A>=
>=0Aendobj=0A18 0 obj=0A<<=0A/Dest [ 7 0 R /XYZ 62.69291 528.0236 0 ] /Pare=
nt 16 0 R /Prev 17 0 R /Title (Eviction)=0A>>=0Aendobj=0A19 0 obj=0A<<=0A/C=
ount 7 /Dest [ 7 0 R /XYZ 62.69291 438.0236 0 ] /First 20 0 R /Last 26 0 R =
/Next 27 0 R /Parent 11 0 R =0A  /Prev 16 0 R /Title (Rationale)=0A>>=0Aend=
obj=0A20 0 obj=0A<<=0A/Count 2 /Dest [ 7 0 R /XYZ 62.69291 405.0236 0 ] /Fi=
rst 21 0 R /Last 22 0 R /Next 23 0 R /Parent 19 0 R =0A  /Title (Characteri=
stics of cloud-era workloads)=0A>>=0Aendobj=0A21 0 obj=0A<<=0A/Dest [ 7 0 R=
 /XYZ 62.69291 345.0236 0 ] /Next 22 0 R /Parent 20 0 R /Title (Memory comp=
osition)=0A>>=0Aendobj=0A22 0 obj=0A<<=0A/Dest [ 7 0 R /XYZ 62.69291 264.02=
36 0 ] /Parent 20 0 R /Prev 21 0 R /Title (The profile of kswapd)=0A>>=0Aen=
dobj=0A23 0 obj=0A<<=0A/Count 2 /Dest [ 8 0 R /XYZ 62.69291 679.8236 0 ] /F=
irst 24 0 R /Last 25 0 R /Next 26 0 R /Parent 19 0 R =0A  /Prev 20 0 R /Tit=
le (Limitations of the current implementation)=0A>>=0Aendobj=0A24 0 obj=0A<=
<=0A/Dest [ 8 0 R /XYZ 62.69291 649.8236 0 ] /Next 25 0 R /Parent 23 0 R /T=
itle (Granularity of the active/inactive)=0A>>=0Aendobj=0A25 0 obj=0A<<=0A/=
Dest [ 8 0 R /XYZ 62.69291 508.8236 0 ] /Parent 23 0 R /Prev 24 0 R /Title =
(Memory locality of the rmap)=0A>>=0Aendobj=0A26 0 obj=0A<<=0A/Dest [ 8 0 R=
 /XYZ 62.69291 415.8236 0 ] /Parent 19 0 R /Prev 23 0 R /Title (How multige=
nerational LRU solves the problems)=0A>>=0Aendobj=0A27 0 obj=0A<<=0A/Count =
3 /Dest [ 8 0 R /XYZ 62.69291 265.8236 0 ] /First 28 0 R /Last 30 0 R /Pare=
nt 11 0 R /Prev 19 0 R =0A  /Title (To-do list)=0A>>=0Aendobj=0A28 0 obj=0A=
<<=0A/Dest [ 8 0 R /XYZ 62.69291 232.8236 0 ] /Next 29 0 R /Parent 27 0 R /=
Title (KVM optimization)=0A>>=0Aendobj=0A29 0 obj=0A<<=0A/Dest [ 8 0 R /XYZ=
 62.69291 184.8236 0 ] /Next 30 0 R /Parent 27 0 R /Prev 28 0 R /Title (NUM=
A optimization)=0A>>=0Aendobj=0A30 0 obj=0A<<=0A/Dest [ 8 0 R /XYZ 62.69291=
 136.8236 0 ] /Parent 27 0 R /Prev 29 0 R /Title (Refault tracking optimiza=
tion)=0A>>=0Aendobj=0A31 0 obj=0A<<=0A/Count 3 /Kids [ 5 0 R 7 0 R 8 0 R ] =
/Type /Pages=0A>>=0Aendobj=0A32 0 obj=0A<<=0A/Length 7498=0A>>=0Astream=0A1=
 0 0 1 0 0 cm  BT /F1 12 Tf 14.4 TL ET=0Aq=0A1 0 0 1 62.69291 741.0236 cm=
=0Aq=0A0 0 0 rg=0ABT 1 0 0 1 0 4 Tm /F2 20 Tf 24 TL 128.8249 0 Td (Multigen=
erational LRU) Tj T* -128.8249 0 Td ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 708.0=
236 cm=0Aq=0ABT 1 0 0 1 0 3.5 Tm 21 TL /F2 17.5 Tf 0 0 0 rg (Quick start) T=
j T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 678.0236 cm=0Aq=0ABT 1 0 0 1 0 3 Tm =
18 TL /F2 15 Tf 0 0 0 rg (Build options) Tj T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.=
69291 666.0236 cm=0AQ=0Aq=0A1 0 0 1 62.69291 651.0236 cm=0A0 0 0 rg=0ABT /F=
1 10 Tf 12 TL ET=0Aq=0A1 0 0 1 6 3 cm=0Aq=0A0 0 0 rg=0ABT 1 0 0 1 0 2 Tm /F=
2 10 Tf 12 TL 26.36937 0 Td (Required:) Tj T* -26.36937 0 Td ET=0AQ=0AQ=0Aq=
=0A1 0 0 1 91.03937 3 cm=0Aq=0ABT 1 0 0 1 0 2 Tm 12 TL /F1 10 Tf 0 0 0 rg (=
Set ) Tj /F3 10 Tf 0 0 0 rg (CONFIG_LRU_GEN=3Dy) Tj /F1 10 Tf 0 0 0 rg (.) =
Tj T* ET=0AQ=0AQ=0Aq=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 624.0236 cm=0A0 0 0 rg=
=0ABT /F1 10 Tf 12 TL ET=0Aq=0A1 0 0 1 6 15 cm=0Aq=0A0 0 0 rg=0ABT 1 0 0 1 =
0 2 Tm /F2 10 Tf 12 TL 29.14937 0 Td (Optional:) Tj T* -29.14937 0 Td ET=0A=
Q=0AQ=0Aq=0A1 0 0 1 91.03937 3 cm=0Aq=0ABT 1 0 0 1 0 14 Tm 3.684581 Tw 12 T=
L /F1 10 Tf 0 0 0 rg (Change ) Tj /F3 10 Tf 0 0 0 rg (CONFIG_NR_LRU_GENS) T=
j /F1 10 Tf 0 0 0 rg ( to a number ) Tj /F3 10 Tf 0 0 0 rg (X) Tj /F1 10 Tf=
 0 0 0 rg ( to support a maximum of ) Tj /F3 10 Tf 0 0 0 rg (X) Tj /F1 10 T=
f 0 0 0 rg  T* 0 Tw (generations.) Tj T* ET=0AQ=0AQ=0Aq=0AQ=0AQ=0Aq=0A1 0 0=
 1 62.69291 609.0236 cm=0A0 0 0 rg=0ABT /F1 10 Tf 12 TL ET=0Aq=0A1 0 0 1 6 =
3 cm=0Aq=0A0 0 0 rg=0ABT 1 0 0 1 0 2 Tm /F2 10 Tf 12 TL 29.14937 0 Td (Opti=
onal:) Tj T* -29.14937 0 Td ET=0AQ=0AQ=0Aq=0A1 0 0 1 91.03937 3 cm=0Aq=0ABT=
 1 0 0 1 0 2 Tm 12 TL /F1 10 Tf 0 0 0 rg (Set ) Tj /F3 10 Tf 0 0 0 rg (CONF=
IG_LRU_GEN_ENABLED=3Dy) Tj /F1 10 Tf 0 0 0 rg ( to turn on by default.) Tj =
T* ET=0AQ=0AQ=0Aq=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 579.0236 cm=0Aq=0ABT 1 0 0=
 1 0 3 Tm 18 TL /F2 15 Tf 0 0 0 rg (Runtime options) Tj T* ET=0AQ=0AQ=0Aq=
=0A1 0 0 1 62.69291 567.0236 cm=0AQ=0Aq=0A1 0 0 1 62.69291 552.0236 cm=0A0 =
0 0 rg=0ABT /F1 10 Tf 12 TL ET=0Aq=0A1 0 0 1 6 3 cm=0Aq=0A0 0 0 rg=0ABT 1 0=
 0 1 0 2 Tm /F2 10 Tf 12 TL 26.36937 0 Td (Required:) Tj T* -26.36937 0 Td =
ET=0AQ=0AQ=0Aq=0A1 0 0 1 91.03937 3 cm=0Aq=0ABT 1 0 0 1 0 2 Tm 12 TL /F3 10=
 Tf 0 0 0 rg (echo) Tj ( ) Tj (1) Tj ( ) Tj (>) Tj (/sys/kernel/mm/lru_gen/=
enable) Tj /F1 10 Tf 0 0 0 rg ( if was not turned on by default.) Tj T* ET=
=0AQ=0AQ=0Aq=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 525.0236 cm=0A0 0 0 rg=0ABT /F1=
 10 Tf 12 TL ET=0Aq=0A1 0 0 1 6 15 cm=0Aq=0A0 0 0 rg=0ABT 1 0 0 1 0 2 Tm /F=
2 10 Tf 12 TL 29.14937 0 Td (Optional:) Tj T* -29.14937 0 Td ET=0AQ=0AQ=0Aq=
=0A1 0 0 1 91.03937 3 cm=0Aq=0ABT 1 0 0 1 0 14 Tm .551155 Tw 12 TL /F1 10 T=
f 0 0 0 rg (Change ) Tj /F3 10 Tf 0 0 0 rg (/sys/kernel/mm/lru_gen/spread) =
Tj /F1 10 Tf 0 0 0 rg ( to a number ) Tj /F3 10 Tf 0 0 0 rg (N) Tj /F1 10 T=
f 0 0 0 rg ( to spread pages out) Tj T* 0 Tw (into ) Tj /F3 10 Tf 0 0 0 rg =
(N+1) Tj /F1 10 Tf 0 0 0 rg ( generations. Larger values make background ag=
ing more aggressive.) Tj T* ET=0AQ=0AQ=0Aq=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 4=
98.0236 cm=0A0 0 0 rg=0ABT /F1 10 Tf 12 TL ET=0Aq=0A1 0 0 1 6 15 cm=0Aq=0A0=
 0 0 rg=0ABT 1 0 0 1 0 2 Tm /F2 10 Tf 12 TL 29.14937 0 Td (Optional:) Tj T*=
 -29.14937 0 Td ET=0AQ=0AQ=0Aq=0A1 0 0 1 91.03937 3 cm=0Aq=0ABT 1 0 0 1 0 1=
4 Tm .205049 Tw 12 TL /F1 10 Tf 0 0 0 rg (Read ) Tj /F3 10 Tf 0 0 0 rg (/sy=
s/kernel/debug/lru_gen) Tj /F1 10 Tf 0 0 0 rg ( to verify the state of mult=
igenerational LRU.) Tj T* 0 Tw (The file has the following format:) Tj T* E=
T=0AQ=0AQ=0Aq=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 416.8236 cm=0Aq=0Aq=0A1 0 0 1 =
0 0 cm=0Aq=0A1 0 0 1 6.6 6.6 cm=0Aq=0A.662745 .662745 .662745 RG=0A.5 w=0A.=
960784 .960784 .862745 rg=0An -6 -6 468.6898 72 re B*=0AQ=0Aq=0A0 0 0 rg=0A=
BT 1 0 0 1 0 50 Tm /F3 10 Tf 12 TL (memcg  memcg_id  memcg_path) Tj T* (  n=
ode  node_id) Tj T* (    min_seq  birth_time  anon_size  file_size) Tj T* (=
    ...) Tj T* (    max_seq  birth_time  anon_size  file_size) Tj T* ET=0AQ=
=0AQ=0AQ=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 384.8236 cm=0Aq=0ABT 1 0 0 1 0 14 T=
m -0.005017 Tw 12 TL /F1 10 Tf 0 0 0 rg (The minimum generation number a.k.=
a. ) Tj /F3 10 Tf 0 0 0 rg (min_seq) Tj /F1 10 Tf 0 0 0 rg ( is the oldest =
of all generations; the maximum generation) Tj T* 0 Tw (number a.k.a. ) Tj =
/F3 10 Tf 0 0 0 rg (max_seq) Tj /F1 10 Tf 0 0 0 rg ( is the youngest. Birth=
 time is in milliseconds. Anon and file sizes are in pages.) Tj T* ET=0AQ=
=0AQ=0Aq=0A1 0 0 1 62.69291 354.8236 cm=0Aq=0ABT 1 0 0 1 0 3 Tm 18 TL /F2 1=
5 Tf 0 0 0 rg (Recipes) Tj T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 342.8236 cm=
=0AQ=0Aq=0A1 0 0 1 62.69291 315.8236 cm=0A0 0 0 rg=0ABT /F1 10 Tf 12 TL ET=
=0Aq=0A1 0 0 1 6 3 cm=0Aq=0A0 0 0 rg=0ABT 1 0 0 1 0 14 Tm /F2 10 Tf 12 TL 1=
9.70937 0 Td (Android on) Tj T* 1.93 0 Td (ARMv8.1+:) Tj T* -21.63937 0 Td =
ET=0AQ=0AQ=0Aq=0A1 0 0 1 91.03937 15 cm=0Aq=0ABT 1 0 0 1 0 2 Tm 12 TL /F3 1=
0 Tf 0 0 0 rg (X=3D4) Tj /F1 10 Tf 0 0 0 rg (, ) Tj /F3 10 Tf 0 0 0 rg (N=
=3D0) Tj T* ET=0AQ=0AQ=0Aq=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 276.8236 cm=0A0 0=
 0 rg=0ABT /F1 10 Tf 12 TL ET=0Aq=0A1 0 0 1 6 3 cm=0Aq=0A0 0 0 rg=0ABT 1 0 =
0 1 0 26 Tm /F2 10 Tf 12 TL 19.70937 0 Td (Android on) Tj T* 3.33 0 Td (old=
er ARM) Tj T* 20 0 Td (CPUs:) Tj T* -43.03937 0 Td ET=0AQ=0AQ=0Aq=0A1 0 0 1=
 91.03937 27 cm=0Aq=0ABT 1 0 0 1 0 2 Tm 12 TL /F1 10 Tf 0 0 0 rg (Not recom=
mended due to the lack of ) Tj /F3 10 Tf 0 0 0 rg (ARM64_HW_AFDBM) Tj T* ET=
=0AQ=0AQ=0Aq=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 225.8236 cm=0A0 0 0 rg=0ABT /F1=
 10 Tf 12 TL ET=0Aq=0A1 0 0 1 6 3 cm=0Aq=0A0 0 0 rg=0ABT 1 0 0 1 0 38 Tm /F=
2 10 Tf 12 TL 8.02937 0 Td (Linux laptops) Tj T* 27.79 0 Td (running) Tj T*=
 -15.56 0 Td (Chrome on) Tj T* 16.09 0 Td (x86_64:) Tj T* -36.34937 0 Td ET=
=0AQ=0AQ=0Aq=0A1 0 0 1 91.03937 39 cm=0Aq=0ABT 1 0 0 1 0 2 Tm 12 TL /F3 10 =
Tf 0 0 0 rg (X=3D7) Tj /F1 10 Tf 0 0 0 rg (, ) Tj /F3 10 Tf 0 0 0 rg (N=3D2=
) Tj T* ET=0AQ=0AQ=0Aq=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 138.8236 cm=0A0 0 0 r=
g=0ABT /F1 10 Tf 12 TL ET=0Aq=0A1 0 0 1 6 63 cm=0Aq=0A0 0 0 rg=0ABT 1 0 0 1=
 0 14 Tm /F2 10 Tf 12 TL 15.80937 0 Td (Working set) Tj T* 3.89 0 Td (estim=
ation:) Tj T* -19.69937 0 Td ET=0AQ=0AQ=0Aq=0A1 0 0 1 91.03937 3 cm=0Aq=0AB=
T 1 0 0 1 0 74 Tm 16.93673 Tw 12 TL /F1 10 Tf 0 0 0 rg (Write ) Tj /F3 10 T=
f 0 0 0 rg (+) Tj ( ) Tj (memcg_id) Tj ( ) Tj (node_id) Tj ( ) Tj (max_seq =
[swappiness]) Tj /F1 10 Tf 0 0 0 rg ( to) Tj T* 0 Tw 5.710056 Tw /F3 10 Tf =
0 0 0 rg (/sys/kernel/debug/lru_gen) Tj /F1 10 Tf 0 0 0 rg ( to scan for ac=
cessed pages, update their) Tj T* 0 Tw 2.059039 Tw (generation numbers to )=
 Tj /F3 10 Tf 0 0 0 rg (max_gen) Tj /F1 10 Tf 0 0 0 rg ( and create the nex=
t generation ) Tj /F3 10 Tf 0 0 0 rg (max_seq+1) Tj /F1 10 Tf 0 0 0 rg (. A=
) Tj T* 0 Tw .8908 Tw (swap file is required to enable anon multigeneration=
al LRU. If swap is not desired,) Tj T* 0 Tw 5.652039 Tw (set ) Tj /F3 10 Tf=
 0 0 0 rg (vm.swappiness) Tj /F1 10 Tf 0 0 0 rg ( to ) Tj /F3 10 Tf 0 0 0 r=
g (0) Tj /F1 10 Tf 0 0 0 rg ( and overwritten it with the optional paramete=
r) Tj T* 0 Tw 1.253377 Tw /F3 10 Tf 0 0 0 rg ([swappiness]) Tj /F1 10 Tf 0 =
0 0 rg (. Otherwise anon multigenerational LRU will not be scanned even) Tj=
 T* 0 Tw (though it is enabled.) Tj T* ET=0AQ=0AQ=0Aq=0AQ=0AQ=0Aq=0A1 0 0 1=
 62.69291 87.82362 cm=0A0 0 0 rg=0ABT /F1 10 Tf 12 TL ET=0Aq=0A1 0 0 1 6 27=
 cm=0Aq=0A0 0 0 rg=0ABT 1 0 0 1 0 14 Tm /F2 10 Tf 12 TL 28.01937 0 Td (Proa=
ctive) Tj T* 6.67 0 Td (reclaim:) Tj T* -34.68937 0 Td ET=0AQ=0AQ=0Aq=0A1 0=
 0 1 91.03937 3 cm=0Aq=0ABT 1 0 0 1 0 38 Tm .802913 Tw 12 TL /F1 10 Tf 0 0 =
0 rg (Write ) Tj /F3 10 Tf 0 0 0 rg (-) Tj ( ) Tj (memcg_id) Tj ( ) Tj (nod=
e_id) Tj ( ) Tj (min_seq) Tj ( ) Tj ([swappiness] [nr_to_reclaim]) Tj /F1 1=
0 Tf 0 0 0 rg ( to) Tj T* 0 Tw 2.648628 Tw /F3 10 Tf 0 0 0 rg (/sys/kernel/=
debug/lru_gen) Tj /F1 10 Tf 0 0 0 rg ( to evict generations older than ) Tj=
 /F3 10 Tf 0 0 0 rg (min_seq) Tj /F1 10 Tf 0 0 0 rg (. The) Tj T* 0 Tw .019=
261 Tw (optional parameter ) Tj /F3 10 Tf 0 0 0 rg (nr_to_reclaim) Tj /F1 1=
0 Tf 0 0 0 rg ( can be used to limit the number of pages to be) Tj T* 0 Tw =
(evicted from the oldest generation.) Tj T* ET=0AQ=0AQ=0Aq=0AQ=0AQ=0A =0Aen=
dstream=0Aendobj=0A33 0 obj=0A<<=0A/Length 5862=0A>>=0Astream=0A1 0 0 1 0 0=
 cm  BT /F1 12 Tf 14.4 TL ET=0Aq=0A1 0 0 1 62.69291 744.0236 cm=0Aq=0ABT 1 =
0 0 1 0 3.5 Tm 21 TL /F2 17.5 Tf 0 0 0 rg (Workflow) Tj T* ET=0AQ=0AQ=0Aq=
=0A1 0 0 1 62.69291 630.0236 cm=0Aq=0ABT 1 0 0 1 0 98 Tm -0.07252 Tw 12 TL =
/F1 10 Tf 0 0 0 rg (Multigenerational LRU uses generation numbers to partit=
ion evictable pages. Raw generation numbers are) Tj T* 0 Tw .990697 Tw (sto=
red in ) Tj /F3 10 Tf 0 0 0 rg (struct) Tj ( ) Tj (lru_gen) Tj /F1 10 Tf 0 =
0 0 rg ( which is a member of ) Tj /F3 10 Tf 0 0 0 rg (struct) Tj ( ) Tj (l=
ruvec) Tj /F1 10 Tf 0 0 0 rg (. The youngest generation number) Tj T* 0 Tw =
=2E417045 Tw /F3 10 Tf 0 0 0 rg (max_seq) Tj /F1 10 Tf 0 0 0 rg ( tracks bo=
th anon and file so they are aged on an equal footing. The oldest generatio=
n numbers) Tj T* 0 Tw .015984 Tw /F3 10 Tf 0 0 0 rg (min_seq[2]) Tj /F1 10 =
Tf 0 0 0 rg ( track anon and file separately so clean file pages can be dro=
pped regardless of swappiness.) Tj T* 0 Tw 5.387976 Tw (Raw generation numb=
ers are truncated into ) Tj /F3 10 Tf 0 0 0 rg (ilog2\(CONFIG_NR_LRU_GENS\)=
+1) Tj /F1 10 Tf 0 0 0 rg ( bits to fit into) Tj T* 0 Tw 4.126342 Tw /F3 10=
 Tf 0 0 0 rg (page-) Tj (>) Tj (flags) Tj /F1 10 Tf 0 0 0 rg (. Sliding win=
dow technique is used to prevent truncated generation numbers from) Tj T* 0=
 Tw .227765 Tw (overlapping, which could be analogized to a ring buffer, wi=
th aging to the writer and eviction to the reader.) Tj T* 0 Tw 1.533318 Tw =
(A set of per-type \(anon/file\) and per-zone page lists is indexed by each=
 truncated generation number.) Tj T* 0 Tw (Pages are added to the lists ind=
exed by ) Tj /F3 10 Tf 0 0 0 rg (max_seq) Tj /F1 10 Tf 0 0 0 rg ( when they=
 are faulted in.) Tj T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 600.0236 cm=0Aq=
=0ABT 1 0 0 1 0 3 Tm 18 TL /F2 15 Tf 0 0 0 rg (Aging) Tj T* ET=0AQ=0AQ=0Aq=
=0A1 0 0 1 62.69291 558.0236 cm=0Aq=0ABT 1 0 0 1 0 26 Tm .541235 Tw 12 TL /=
F1 10 Tf 0 0 0 rg (Aging produces new generations. For each aging cycle, al=
l mapped pages that belong to an ) Tj /F3 10 Tf 0 0 0 rg (lruvec) Tj /F1 10=
 Tf 0 0 0 rg ( are) Tj T* 0 Tw 1.013318 Tw (scanned. For pages that have be=
en accessed since last scan, their generation numbers are updated to) Tj T*=
 0 Tw /F3 10 Tf 0 0 0 rg (max_seq) Tj /F1 10 Tf 0 0 0 rg (. ) Tj /F3 10 Tf =
0 0 0 rg (max_seq) Tj /F1 10 Tf 0 0 0 rg ( is incremented at the end of eac=
h cycle.) Tj T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 540.0236 cm=0Aq=0A0 0 0 r=
g=0ABT 1 0 0 1 0 2 Tm /F1 10 Tf 12 TL (Aging maintains system- or memcg-wid=
e mm list to scan mapped pages at minimum cost.) Tj T* ET=0AQ=0AQ=0Aq=0A1 0=
 0 1 62.69291 510.0236 cm=0Aq=0ABT 1 0 0 1 0 3 Tm 18 TL /F2 15 Tf 0 0 0 rg =
(Eviction) Tj T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 468.0236 cm=0Aq=0ABT 1 0=
 0 1 0 26 Tm 1.087674 Tw 12 TL /F1 10 Tf 0 0 0 rg (Eviction consumes old ge=
nerations. Pages on the per-zone lists indexed by ) Tj /F3 10 Tf 0 0 0 rg (=
min_seq[2]) Tj /F1 10 Tf 0 0 0 rg ( are scanned.) Tj T* 0 Tw 2.553555 Tw (A=
nd pages are either sorted or isolated, depending on whether aging has upda=
ted their generation) Tj T* 0 Tw (numbers. Either ) Tj /F3 10 Tf 0 0 0 rg (=
min_seq) Tj /F1 10 Tf 0 0 0 rg ( is incremented when there are no pages lef=
t on its lists.) Tj T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 450.0236 cm=0Aq=0A=
0 0 0 rg=0ABT 1 0 0 1 0 2 Tm /F1 10 Tf 12 TL (Eviction selects a type \(ano=
n/file\) simply based on generations and swappiness.) Tj T* ET=0AQ=0AQ=0Aq=
=0A1 0 0 1 62.69291 417.0236 cm=0Aq=0ABT 1 0 0 1 0 3.5 Tm 21 TL /F2 17.5 Tf=
 0 0 0 rg (Rationale) Tj T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 387.0236 cm=
=0Aq=0ABT 1 0 0 1 0 3 Tm 18 TL /F2 15 Tf 0 0 0 rg (Characteristics of cloud=
-era workloads) Tj T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 357.0236 cm=0Aq=0A0=
 0 0 rg=0ABT 1 0 0 1 0 14 Tm /F1 10 Tf 12 TL 1.36784 Tw (Warning: though th=
e following observations are made across millions of servers and clients at=
 Google,) Tj T* 0 Tw (they may not be universally applicable.) Tj T* ET=0AQ=
=0AQ=0Aq=0A1 0 0 1 62.69291 330.0236 cm=0Aq=0ABT 1 0 0 1 0 2.5 Tm 15 TL /F4=
 12.5 Tf 0 0 0 rg (Memory composition) Tj T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69=
291 276.0236 cm=0Aq=0ABT 1 0 0 1 0 38 Tm .812126 Tw 12 TL /F1 10 Tf 0 0 0 r=
g (With cloud storage gone mainstream, anonymous memory is now the majority=
 and page cache contains) Tj T* 0 Tw .014269 Tw (mostly executable pages an=
d negligible unmapped pages. In addition, userspace is smart enough to avoi=
d) Tj T* 0 Tw 1.037984 Tw (page cache thrashing by taking advantage of AIO,=
 direct I/O and ) Tj /F3 10 Tf 0 0 0 rg (io_uring) Tj /F1 10 Tf 0 0 0 rg ( =
when streaming large files) Tj T* 0 Tw (stored locally.) Tj T* ET=0AQ=0AQ=
=0Aq=0A1 0 0 1 62.69291 249.0236 cm=0Aq=0ABT 1 0 0 1 0 2.5 Tm 15 TL /F4 12.=
5 Tf 0 0 0 rg (The profile of ) Tj /F3 12.5 Tf 0 0 0 rg (kswapd) Tj T* ET=
=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 207.0236 cm=0Aq=0ABT 1 0 0 1 0 26 Tm 1.7292=
13 Tw 12 TL /F1 10 Tf 0 0 0 rg (As a result of the aforementioned memory co=
mposition, swapping is necessary to achieve substantial) Tj T* 0 Tw 1.03641=
2 Tw (memory overcommit. And since almost all pages are mapped, the ) Tj /F=
3 10 Tf 0 0 0 rg (rmap) Tj /F1 10 Tf 0 0 0 rg ( surpasses ) Tj /F3 10 Tf 0 =
0 0 rg (zram) Tj /F1 10 Tf 0 0 0 rg ( and becomes) Tj T* 0 Tw (the hottest =
path in ) Tj /F3 10 Tf 0 0 0 rg (kswapd) Tj /F1 10 Tf 0 0 0 rg (.) Tj T* ET=
=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 189.0236 cm=0Aq=0ABT 1 0 0 1 0 2 Tm 12 TL /=
F1 10 Tf 0 0 0 rg (For ) Tj /F3 10 Tf 0 0 0 rg (zram) Tj /F1 10 Tf 0 0 0 rg=
 (, a typical ) Tj /F3 10 Tf 0 0 0 rg (kswapd) Tj /F1 10 Tf 0 0 0 rg ( prof=
ile on v5.11 looks like:) Tj T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 107.8236 =
cm=0Aq=0Aq=0A1 0 0 1 0 0 cm=0Aq=0A1 0 0 1 6.6 6.6 cm=0Aq=0A.662745 .662745 =
=2E662745 RG=0A.5 w=0A.960784 .960784 .862745 rg=0An -6 -6 468.6898 72 re B=
*=0AQ=0Aq=0A0 0 0 rg=0ABT 1 0 0 1 0 50 Tm /F3 10 Tf 12 TL (31.03%  page_vma=
_mapped_walk) Tj T* (25.59%  lzo1x_1_do_compress) Tj T* ( 4.63%  do_raw_spi=
n_lock) Tj T* ( 3.89%  vma_interval_tree_iter_next) Tj T* ( 3.33%  vma_inte=
rval_tree_subtree_search) Tj T* ET=0AQ=0AQ=0AQ=0AQ=0AQ=0Aq=0A1 0 0 1 62.692=
91 87.82362 cm=0Aq=0A0 0 0 rg=0ABT 1 0 0 1 0 2 Tm /F1 10 Tf 12 TL (And for =
disk swap, it looks like:) Tj T* ET=0AQ=0AQ=0A =0Aendstream=0Aendobj=0A34 0=
 obj=0A<<=0A/Length 5256=0A>>=0Astream=0A1 0 0 1 0 0 cm  BT /F1 12 Tf 14.4 =
TL ET=0Aq=0A1 0 0 1 62.69291 691.8236 cm=0Aq=0Aq=0A1 0 0 1 0 0 cm=0Aq=0A1 0=
 0 1 6.6 6.6 cm=0Aq=0A.662745 .662745 .662745 RG=0A.5 w=0A.960784 .960784 .=
862745 rg=0An -6 -6 468.6898 72 re B*=0AQ=0Aq=0A0 0 0 rg=0ABT 1 0 0 1 0 50 =
Tm /F3 10 Tf 12 TL (45.16%  page_vma_mapped_walk) Tj T* ( 7.61%  do_raw_spi=
n_lock) Tj T* ( 5.69%  vma_interval_tree_iter_next) Tj T* ( 4.91%  vma_inte=
rval_tree_subtree_search) Tj T* ( 3.71%  page_referenced_one) Tj T* ET=0AQ=
=0AQ=0AQ=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 661.8236 cm=0Aq=0ABT 1 0 0 1 0 3 Tm=
 18 TL /F2 15 Tf 0 0 0 rg (Limitations of the current implementation) Tj T*=
 ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 634.8236 cm=0Aq=0ABT 1 0 0 1 0 2.5 Tm 15=
 TL /F4 12.5 Tf 0 0 0 rg (Granularity of the active/inactive) Tj T* ET=0AQ=
=0AQ=0Aq=0A1 0 0 1 62.69291 592.8236 cm=0Aq=0A0 0 0 rg=0ABT 1 0 0 1 0 26 Tm=
 /F1 10 Tf 12 TL .497984 Tw (For large systems that have tens or hundreds g=
igabytes of memory, the active/inactive sizes become too) Tj T* 0 Tw 1.5781=
1 Tw (coarse to be useful for memory overcommit. Pages counted as active ca=
n be less recently used than) Tj T* 0 Tw (pages counted as inactive because=
 they will not be scanned until most inactive pages have.) Tj T* ET=0AQ=0AQ=
=0Aq=0A1 0 0 1 62.69291 550.8236 cm=0Aq=0A0 0 0 rg=0ABT 1 0 0 1 0 26 Tm /F1=
 10 Tf 12 TL .81436 Tw (For smaller systems, eviction is biased between ano=
n and file because the selection is mainly based on) Tj T* 0 Tw .745366 Tw =
(inference not direct comparisons. For example, on Chrome OS, executable pa=
ges are frequently evicted) Tj T* 0 Tw (despite the fact that there are man=
y less recently used anon pages.) Tj T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 5=
20.8236 cm=0Aq=0ABT 1 0 0 1 0 14 Tm 3.874147 Tw 12 TL /F1 10 Tf 0 0 0 rg (W=
hen there are multiple ) Tj /F3 10 Tf 0 0 0 rg (lruvec) Tj /F1 10 Tf 0 0 0 =
rg (s, the active/inactive notion becomes even less useful because) Tj T* 0=
 Tw (comparisons between pages from different ) Tj /F3 10 Tf 0 0 0 rg (lruv=
ec) Tj /F1 10 Tf 0 0 0 rg (s is impossible based on this notion.) Tj T* ET=
=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 493.8236 cm=0Aq=0ABT 1 0 0 1 0 2.5 Tm 15 TL=
 /F4 12.5 Tf 0 0 0 rg (Memory locality of the ) Tj /F3 12.5 Tf 0 0 0 rg (rm=
ap) Tj T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 427.8236 cm=0Aq=0ABT 1 0 0 1 0 =
50 Tm .007882 Tw 12 TL /F1 10 Tf 0 0 0 rg (The ) Tj /F3 10 Tf 0 0 0 rg (rma=
p) Tj /F1 10 Tf 0 0 0 rg ( has poor memory locality because of its complex =
data structures. On top of it, at least two walks) Tj T* 0 Tw 1.756488 Tw (=
of the ) Tj /F3 10 Tf 0 0 0 rg (rmap) Tj /F1 10 Tf 0 0 0 rg ( are required =
before a page can be evicted after it is faulted in. The first walk clears =
the) Tj T* 0 Tw .195542 Tw (accessed bit set upon the fault; the second wal=
k verifies the page has not been accessed since then. Due) Tj T* 0 Tw 2.351=
318 Tw (to the both factors, the cost of memory overcommit becomes signific=
ant when almost all pages are) Tj T* 0 Tw (mapped but only accessed every f=
ew minutes.) Tj T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 397.8236 cm=0Aq=0ABT 1=
 0 0 1 0 3 Tm 18 TL /F2 15 Tf 0 0 0 rg (How multigenerational LRU solves th=
e problems) Tj T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 355.8236 cm=0Aq=0ABT 1 =
0 0 1 0 26 Tm .458443 Tw 12 TL /F1 10 Tf 0 0 0 rg (Multigenerational LRU in=
troduces a quantitative way to overcommit memory. For an ) Tj /F3 10 Tf 0 0=
 0 rg (lruvec) Tj /F1 10 Tf 0 0 0 rg (, pages from) Tj T* 0 Tw .949985 Tw (=
an older generation are guaranteed to be less recently used than those from=
 a younger generation. For) Tj T* 0 Tw (different ) Tj /F3 10 Tf 0 0 0 rg (=
lruvec) Tj /F1 10 Tf 0 0 0 rg (s, comparisons can be made approximately bas=
ed on birth times.) Tj T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 277.8236 cm=0Aq=
=0ABT 1 0 0 1 0 62 Tm -0.023902 Tw 12 TL /F1 10 Tf 0 0 0 rg (Page tables ha=
ve far better memory locality than the ) Tj /F3 10 Tf 0 0 0 rg (rmap) Tj /F=
1 10 Tf 0 0 0 rg ( when it comes to checking the accessed bit. As) Tj T* 0 =
Tw .39811 Tw (counterintuitive as it may seem, for cloud-era workloads, tra=
cking all accessed pages via page tables is a) Tj T* 0 Tw .684987 Tw (lot l=
ess expensive than scanning pages one by one via the ) Tj /F3 10 Tf 0 0 0 r=
g (rmap) Tj /F1 10 Tf 0 0 0 rg (. The overhead from page table walk is) Tj =
T* 0 Tw .208221 Tw (proportional to the number of accessed pages, and the w=
alk is only required when most pages have been) Tj T* 0 Tw .959398 Tw (acce=
ssed. At this point, scanning pages one by one would be very inefficient be=
cause of the number of) Tj T* 0 Tw (pages to cover.) Tj T* ET=0AQ=0AQ=0Aq=
=0A1 0 0 1 62.69291 244.8236 cm=0Aq=0ABT 1 0 0 1 0 3.5 Tm 21 TL /F2 17.5 Tf=
 0 0 0 rg (To-do list) Tj T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 214.8236 cm=
=0Aq=0ABT 1 0 0 1 0 3 Tm 18 TL /F2 15 Tf 0 0 0 rg (KVM optimization) Tj T* =
ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 196.8236 cm=0Aq=0A0 0 0 rg=0ABT 1 0 0 1 0=
 2 Tm /F1 10 Tf 12 TL (Support shadow page table walk.) Tj T* ET=0AQ=0AQ=0A=
q=0A1 0 0 1 62.69291 166.8236 cm=0Aq=0ABT 1 0 0 1 0 3 Tm 18 TL /F2 15 Tf 0 =
0 0 rg (NUMA optimization) Tj T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 148.8236=
 cm=0Aq=0A0 0 0 rg=0ABT 1 0 0 1 0 2 Tm /F1 10 Tf 12 TL (Add per-node RSS fo=
r should_skip_mm\(\).) Tj T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 118.8236 cm=
=0Aq=0ABT 1 0 0 1 0 3 Tm 18 TL /F2 15 Tf 0 0 0 rg (Refault tracking optimiz=
ation) Tj T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 100.8236 cm=0Aq=0A0 0 0 rg=
=0ABT 1 0 0 1 0 2 Tm /F1 10 Tf 12 TL (Use generation numbers rather than LR=
U positions in workingset_eviction\(\) and workingset_refault\(\).) Tj T* E=
T=0AQ=0AQ=0A =0Aendstream=0Aendobj=0A35 0 obj=0A<<=0A/Nums [ 0 36 0 R 1 37 =
0 R 2 38 0 R ]=0A>>=0Aendobj=0A36 0 obj=0A<<=0A/S /D /St 1=0A>>=0Aendobj=0A=
37 0 obj=0A<<=0A/S /D /St 2=0A>>=0Aendobj=0A38 0 obj=0A<<=0A/S /D /St 3=0A>=
>=0Aendobj=0Axref=0A0 39=0A0000000000 65535 f =0A0000000073 00000 n =0A0000=
000134 00000 n =0A0000000241 00000 n =0A0000000353 00000 n =0A0000000458 00=
000 n =0A0000000663 00000 n =0A0000000782 00000 n =0A0000000987 00000 n =0A=
0000001192 00000 n =0A0000001297 00000 n =0A0000001576 00000 n =0A000000165=
1 00000 n =0A0000001802 00000 n =0A0000001916 00000 n =0A0000002045 00000 n=
 =0A0000002153 00000 n =0A0000002314 00000 n =0A0000002420 00000 n =0A00000=
02529 00000 n =0A0000002691 00000 n =0A0000002869 00000 n =0A0000002988 000=
00 n =0A0000003110 00000 n =0A0000003304 00000 n =0A0000003439 00000 n =0A0=
000003567 00000 n =0A0000003713 00000 n =0A0000003863 00000 n =0A0000003980=
 00000 n =0A0000004111 00000 n =0A0000004241 00000 n =0A0000004313 00000 n =
=0A0000011863 00000 n =0A0000017777 00000 n =0A0000023085 00000 n =0A000002=
3144 00000 n =0A0000023178 00000 n =0A0000023212 00000 n =0Atrailer=0A<<=0A=
/ID =0A[<9a97ee91b979d1c9ec8158482a5de941><9a97ee91b979d1c9ec8158482a5de941=
>]=0A% ReportLab generated PDF document -- digest (http://www.reportlab.com=
)=0A=0A/Info 10 0 R=0A/Root 9 0 R=0A/Size 39=0A>>=0Astartxref=0A23246=0A%%E=
OF=0A
--dl73G/axgAFsWD6w
Content-Type: application/pdf
Content-Disposition: attachment; filename="man.pdf"
Content-Transfer-Encoding: quoted-printable

%PDF-1.4=0A%=93=8C=8B=9E ReportLab Generated PDF document http://www.report=
lab.com=0A1 0 obj=0A<<=0A/F1 2 0 R /F2 3 0 R /F3 4 0 R=0A>>=0Aendobj=0A2 0 =
obj=0A<<=0A/BaseFont /Helvetica /Encoding /WinAnsiEncoding /Name /F1 /Subty=
pe /Type1 /Type /Font=0A>>=0Aendobj=0A3 0 obj=0A<<=0A/BaseFont /Helvetica-B=
old /Encoding /WinAnsiEncoding /Name /F2 /Subtype /Type1 /Type /Font=0A>>=
=0Aendobj=0A4 0 obj=0A<<=0A/BaseFont /Courier /Encoding /WinAnsiEncoding /N=
ame /F3 /Subtype /Type1 /Type /Font=0A>>=0Aendobj=0A5 0 obj=0A<<=0A/Border =
[ 0 0 0 ] /Contents () /Dest [ 18 0 R /XYZ 68.69291 408.9843 0 ] /Rect [ 44=
5.0657 449.0236 460.6337 461.0236 ] /Subtype /Link /Type /Annot=0A>>=0Aendo=
bj=0A6 0 obj=0A<<=0A/Border [ 0 0 0 ] /Contents () /Dest [ 18 0 R /XYZ 68.6=
9291 408.9843 0 ] /Rect [ 124.8421 350.0236 140.4101 362.0236 ] /Subtype /L=
ink /Type /Annot=0A>>=0Aendobj=0A7 0 obj=0A<<=0A/A <<=0A/S /URI /Type /Acti=
on /URI (https://linux-mm.googlesource.com/page-reclaim)=0A>> /Border [ 0 0=
 0 ] /Rect [ 94.37291 275.0236 309.9929 287.0236 ] /Subtype /Link /Type /An=
not=0A>>=0Aendobj=0A8 0 obj=0A<<=0A/A <<=0A/S /URI /Type /Action /URI (http=
s://linux-mm-review.googlesource.com/c/page-reclaim/+/1080)=0A>> /Border [ =
0 0 0 ] /Rect [ 93.25291 257.0236 382.5129 269.0236 ] /Subtype /Link /Type =
/Annot=0A>>=0Aendobj=0A9 0 obj=0A<<=0A/Border [ 0 0 0 ] /Contents () /Dest =
[ 18 0 R /XYZ 68.69291 408.9843 0 ] /Rect [ 62.69291 152.0236 78.26091 164.=
0236 ] /Subtype /Link /Type /Annot=0A>>=0Aendobj=0A10 0 obj=0A<<=0A/Border =
[ 0 0 0 ] /Contents () /Dest [ 18 0 R /XYZ 68.69291 408.9843 0 ] /Rect [ 31=
4.9695 104.0236 330.5375 116.0236 ] /Subtype /Link /Type /Annot=0A>>=0Aendo=
bj=0A11 0 obj=0A<<=0A/Annots [ 5 0 R 6 0 R 7 0 R 8 0 R 9 0 R 10 0 R ] /Cont=
ents 33 0 R /MediaBox [ 0 0 595.2756 841.8898 ] /Parent 32 0 R /Resources <=
<=0A/Font 1 0 R /ProcSet [ /PDF /Text /ImageB /ImageC /ImageI ]=0A>> /Rotat=
e 0 =0A  /Trans <<=0A=0A>> /Type /Page=0A>>=0Aendobj=0A12 0 obj=0A<<=0A/Bor=
der [ 0 0 0 ] /Contents () /Dest [ 18 0 R /XYZ 68.69291 408.9843 0 ] /Rect =
[ 129.3729 705.0236 144.9409 717.0236 ] /Subtype /Link /Type /Annot=0A>>=0A=
endobj=0A13 0 obj=0A<<=0A/A <<=0A/S /URI /Type /Action /URI (https://resear=
ch.google/pubs/pub43017/)=0A>> /Border [ 0 0 0 ] /Rect [ 88.69291 561.0236 =
344.8929 573.0236 ] /Subtype /Link /Type /Annot=0A>>=0Aendobj=0A14 0 obj=0A=
<<=0A/A <<=0A/S /URI /Type /Action /URI (https://research.google/pubs/pub44=
271/)=0A>> /Border [ 0 0 0 ] /Rect [ 88.69291 543.0236 255.9729 555.0236 ] =
/Subtype /Link /Type /Annot=0A>>=0Aendobj=0A15 0 obj=0A<<=0A/A <<=0A/S /URI=
 /Type /Action /URI (https://research.google/pubs/pub48329/)=0A>> /Border [=
 0 0 0 ] /Rect [ 88.69291 525.0236 394.9029 537.0236 ] /Subtype /Link /Type=
 /Annot=0A>>=0Aendobj=0A16 0 obj=0A<<=0A/A <<=0A/S /URI /Type /Action /URI =
(https://research.google/pubs/pub48551/)=0A>> /Border [ 0 0 0 ] /Rect [ 88.=
69291 507.0236 356.0029 519.0236 ] /Subtype /Link /Type /Annot=0A>>=0Aendob=
j=0A17 0 obj=0A<<=0A/A <<=0A/S /URI /Type /Action /URI (https://research.go=
ogle/pubs/pub49065/)=0A>> /Border [ 0 0 0 ] /Rect [ 88.69291 489.0236 204.8=
629 501.0236 ] /Subtype /Link /Type /Annot=0A>>=0Aendobj=0A18 0 obj=0A<<=0A=
/Annots [ 12 0 R 13 0 R 14 0 R 15 0 R 16 0 R 17 0 R ] /Contents 34 0 R /Med=
iaBox [ 0 0 595.2756 841.8898 ] /Parent 32 0 R /Resources <<=0A/Font 1 0 R =
/ProcSet [ /PDF /Text /ImageB /ImageC /ImageI ]=0A>> /Rotate 0 =0A  /Trans =
<<=0A=0A>> /Type /Page=0A>>=0Aendobj=0A19 0 obj=0A<<=0A/Outlines 21 0 R /Pa=
geLabels 35 0 R /PageMode /UseNone /Pages 32 0 R /Type /Catalog=0A>>=0Aendo=
bj=0A20 0 obj=0A<<=0A/Author () /CreationDate (D:20210121175546+00'00') /Cr=
eator (\(unspecified\)) /Keywords () /ModDate (D:20210121175546+00'00') /Pr=
oducer (ReportLab PDF Library - www.reportlab.com) =0A  /Subject (\(unspeci=
fied\)) /Title (Augmented Page Reclaim) /Trapped /False=0A>>=0Aendobj=0A21 =
0 obj=0A<<=0A/Count 11 /First 22 0 R /Last 31 0 R /Type /Outlines=0A>>=0Aen=
dobj=0A22 0 obj=0A<<=0A/Dest [ 11 0 R /XYZ 62.69291 671.0236 0 ] /Next 23 0=
 R /Parent 21 0 R /Title (Performance)=0A>>=0Aendobj=0A23 0 obj=0A<<=0A/Des=
t [ 11 0 R /XYZ 62.69291 488.0236 0 ] /Next 24 0 R /Parent 21 0 R /Prev 22 =
0 R /Title (Versatility)=0A>>=0Aendobj=0A24 0 obj=0A<<=0A/Dest [ 11 0 R /XY=
Z 62.69291 389.0236 0 ] /Next 25 0 R /Parent 21 0 R /Prev 23 0 R /Title (Si=
mplicity)=0A>>=0Aendobj=0A25 0 obj=0A<<=0A/Dest [ 11 0 R /XYZ 62.69291 314.=
0236 0 ] /Next 26 0 R /Parent 21 0 R /Prev 24 0 R /Title (Repo)=0A>>=0Aendo=
bj=0A26 0 obj=0A<<=0A/Count 4 /Dest [ 11 0 R /XYZ 62.69291 245.0236 0 ] /Fi=
rst 27 0 R /Last 30 0 R /Next 31 0 R /Parent 21 0 R =0A  /Prev 25 0 R /Titl=
e (FAQ)=0A>>=0Aendobj=0A27 0 obj=0A<<=0A/Dest [ 11 0 R /XYZ 62.69291 212.02=
36 0 ] /Next 28 0 R /Parent 26 0 R /Title (What is the motivation for this =
work?)=0A>>=0Aendobj=0A28 0 obj=0A<<=0A/Dest [ 11 0 R /XYZ 62.69291 140.023=
6 0 ] /Next 29 0 R /Parent 26 0 R /Prev 27 0 R /Title (Why not try to impro=
ve the existing code?)=0A>>=0Aendobj=0A29 0 obj=0A<<=0A/Dest [ 18 0 R /XYZ =
62.69291 765.0236 0 ] /Next 30 0 R /Parent 26 0 R /Prev 28 0 R /Title (What=
 particular workloads does it help?)=0A>>=0Aendobj=0A30 0 obj=0A<<=0A/Dest =
[ 18 0 R /XYZ 62.69291 693.0236 0 ] /Parent 26 0 R /Prev 29 0 R /Title (How=
 would it benefit the community?)=0A>>=0Aendobj=0A31 0 obj=0A<<=0A/Dest [ 1=
8 0 R /XYZ 62.69291 609.0236 0 ] /Parent 21 0 R /Prev 26 0 R /Title (Refere=
nces)=0A>>=0Aendobj=0A32 0 obj=0A<<=0A/Count 2 /Kids [ 11 0 R 18 0 R ] /Typ=
e /Pages=0A>>=0Aendobj=0A33 0 obj=0A<<=0A/Length 5575=0A>>=0Astream=0A1 0 0=
 1 0 0 cm  BT /F1 12 Tf 14.4 TL ET=0Aq=0A1 0 0 1 62.69291 741.0236 cm=0Aq=
=0A0 0 0 rg=0ABT 1 0 0 1 0 4 Tm /F2 20 Tf 24 TL 112.1349 0 Td (Augmented Pa=
ge Reclaim) Tj T* -112.1349 0 Td ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 683.0236=
 cm=0Aq=0ABT 1 0 0 1 0 38 Tm -0.115465 Tw 12 TL /F1 10 Tf 0 0 0 rg (We woul=
d like to share a work with you and see if there is enough interest to warr=
ant a run for the mainline.) Tj T* 0 Tw 1.324104 Tw (This work is a part of=
 result from a decade of research and experimentation in memory overcommit =
at) Tj T* 0 Tw 3.993828 Tw (Google: an augmented page reclaim that, in our =
experience, is performant, versatile and, more) Tj T* 0 Tw (importantly, si=
mple.) Tj T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 650.0236 cm=0Aq=0ABT 1 0 0 1=
 0 3.5 Tm 21 TL /F2 17.5 Tf 0 0 0 rg (Performance) Tj T* ET=0AQ=0AQ=0Aq=0A1=
 0 0 1 62.69291 608.0236 cm=0Aq=0ABT 1 0 0 1 0 26 Tm .833059 Tw 12 TL /F1 1=
0 Tf 0 0 0 rg (On Android, our most advanced simulation that generates memo=
ry pressure from realistic user behavior) Tj T* 0 Tw -0.076124 Tw (shows 18=
% fewer low-memory kills, which in turn reduces cold starts by 16%. This is=
 on top of per-process) Tj T* 0 Tw (reclaim, a predecessor of ) Tj /F3 10 T=
f 0 0 0 rg (MADV_COLD) Tj /F1 10 Tf 0 0 0 rg ( and ) Tj /F3 10 Tf 0 0 0 rg =
(MADV_PAGEOUT) Tj /F1 10 Tf 0 0 0 rg (, against background apps.) Tj T* ET=
=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 554.0236 cm=0Aq=0A0 0 0 rg=0ABT 1 0 0 1 0 3=
8 Tm /F1 10 Tf 12 TL 1.516136 Tw (On Borg \(warehouse-scale computers\), a =
similar approach enables us to identify jobs that underutilize) Tj T* 0 Tw =
=2E834597 Tw (their memory and downsize them considerably without compromis=
ing any of our service level indicators.) Tj T* 0 Tw .536654 Tw (Our findin=
gs are published in the papers listed below, e.g., 32% of memory usage on B=
org has been idle) Tj T* 0 Tw (for at least 2 minutes.) Tj T* ET=0AQ=0AQ=0A=
q=0A1 0 0 1 62.69291 500.0236 cm=0Aq=0ABT 1 0 0 1 0 38 Tm .15811 Tw 12 TL /=
F1 10 Tf 0 0 0 rg (On Chrome OS, our field telemetry reports 96% fewer low-=
memory tab discards and 59% fewer OOM kills) Tj T* 0 Tw 1.136647 Tw (from f=
ully-utilized devices and no UX regressions from underutilized devices. Our=
 real-world benchmark) Tj T* 0 Tw .099318 Tw (that browses popular websites=
 in multiple tabs demonstrates 51% less CPU usage from ) Tj /F3 10 Tf 0 0 0=
 rg (kswapd) Tj /F1 10 Tf 0 0 0 rg ( and 45%) Tj T* 0 Tw (\(some\) and 52% =
\(full\) less PSI on v5.11-rc6 built from the tree below.) Tj T* ET=0AQ=0AQ=
=0Aq=0A1 0 0 1 62.69291 467.0236 cm=0Aq=0ABT 1 0 0 1 0 3.5 Tm 21 TL /F2 17.=
5 Tf 0 0 0 rg (Versatility) Tj T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 401.023=
6 cm=0Aq=0ABT 1 0 0 1 0 50 Tm 1.382983 Tw 12 TL /F1 10 Tf 0 0 0 rg (Userspa=
ce can trigger aging and eviction independently via the ) Tj /F3 10 Tf 0 0 =
0 rg (debugfs) Tj /F1 10 Tf 0 0 0 rg ( interface ) Tj /F1 8 Tf 0 0 .501961 =
rg 5 Ts (note) Tj /F1 10 Tf 0 0 0 rg 0 Ts ( for working set) Tj T* 0 Tw .66=
5366 Tw (estimation, proactive reclaim, far memory tiering, NUMA-aware job =
scheduling, etc. The metrics from the) Tj T* 0 Tw .149213 Tw (interface are=
 easily interpretable, which allows intuitive provisioning and discoveries =
like the Borg example) Tj T* 0 Tw .56936 Tw (above. For a warehouse-scale c=
omputer, the interface is intended to be a building block of a closed-loop)=
 Tj T* 0 Tw (control system, with a machine learning algorithm being the co=
ntroller.) Tj T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 368.0236 cm=0Aq=0ABT 1 0=
 0 1 0 3.5 Tm 21 TL /F2 17.5 Tf 0 0 0 rg (Simplicity) Tj T* ET=0AQ=0AQ=0Aq=
=0A1 0 0 1 62.69291 326.0236 cm=0Aq=0ABT 1 0 0 1 0 26 Tm .234588 Tw 12 TL /=
F1 10 Tf 0 0 0 rg (The workflow ) Tj /F1 8 Tf 0 0 .501961 rg 5 Ts (note) Tj=
 /F1 10 Tf 0 0 0 rg 0 Ts ( is well defined and each step in it has a clear =
meaning. There are no magic numbers or) Tj T* 0 Tw 1.091412 Tw (heuristics =
involved but a few basic data structures that have negligible memory footpr=
int. This simplicity) Tj T* 0 Tw (has served us well as the scale and the d=
iversity of our workloads constantly grow.) Tj T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 =
62.69291 293.0236 cm=0Aq=0ABT 1 0 0 1 0 3.5 Tm 21 TL /F2 17.5 Tf 0 0 0 rg (=
Repo) Tj T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 275.0236 cm=0Aq=0ABT 1 0 0 1 =
0 2 Tm 12 TL /F1 10 Tf 0 0 0 rg (git pull ) Tj 0 0 .501961 rg (https://linu=
x-mm.googlesource.com/page-reclaim) Tj 0 0 0 rg ( refs/changes/80/1080/1) T=
j T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 257.0236 cm=0Aq=0ABT 1 0 0 1 0 2 Tm =
12 TL /F1 10 Tf 0 0 0 rg (Gerrit: ) Tj 0 0 .501961 rg (https://linux-mm-rev=
iew.googlesource.com/c/page-reclaim/+/1080) Tj T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 =
62.69291 224.0236 cm=0Aq=0ABT 1 0 0 1 0 3.5 Tm 21 TL /F2 17.5 Tf 0 0 0 rg (=
FAQ) Tj T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 194.0236 cm=0Aq=0ABT 1 0 0 1 0=
 3 Tm 18 TL /F2 15 Tf 0 0 0 rg (What is the motivation for this work?) Tj T=
* ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 152.0236 cm=0Aq=0ABT 1 0 0 1 0 26 Tm -0=
=2E076124 Tw 12 TL /F1 10 Tf 0 0 0 rg (In our case, DRAM is a major factor =
in total cost of ownership, and improving memory overcommit brings a) Tj T*=
 0 Tw .745366 Tw (high return on investment. Moreover, Google-Wide Profilin=
g has been observing the high CPU overhead) Tj  T* 0 Tw /F1 8 Tf 0 0 .50196=
1 rg 5 Ts (note) Tj /F1 10 Tf 0 0 0 rg 0 Ts ( from page reclaim.) Tj T* ET=
=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 122.0236 cm=0Aq=0ABT 1 0 0 1 0 3 Tm 18 TL /=
F2 15 Tf 0 0 0 rg (Why not try to improve the existing code?) Tj T* ET=0AQ=
=0AQ=0Aq=0A1 0 0 1 62.69291 92.02362 cm=0Aq=0ABT 1 0 0 1 0 14 Tm 2.340735 T=
w 12 TL /F1 10 Tf 0 0 0 rg (We have tried but concluded the two limiting fa=
ctors ) Tj /F1 8 Tf 0 0 .501961 rg 5 Ts (note) Tj /F1 10 Tf 0 0 0 rg 0 Ts (=
 in the existing code are fundamental, and) Tj T* 0 Tw (therefore changes m=
ade atop them will not result in substantial gains on any of the aspects ab=
ove.) Tj T* ET=0AQ=0AQ=0A =0Aendstream=0Aendobj=0A34 0 obj=0A<<=0A/Length 3=
608=0A>>=0Astream=0A1 0 0 1 0 0 cm  BT /F1 12 Tf 14.4 TL ET=0Aq=0A1 0 0 1 6=
2.69291 747.0236 cm=0Aq=0ABT 1 0 0 1 0 3 Tm 18 TL /F2 15 Tf 0 0 0 rg (What =
particular workloads does it help?) Tj T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291=
 705.0236 cm=0Aq=0ABT 1 0 0 1 0 26 Tm .198876 Tw 12 TL /F1 10 Tf 0 0 0 rg (=
This work optimizes page reclaim for workloads that are not IO bound, becau=
se we find they are the norm) Tj T* 0 Tw 1.032765 Tw (on servers and client=
s in the cloud era. It would most likely help any workloads that share the =
common) Tj T* 0 Tw (characteristics ) Tj /F1 8 Tf 0 0 .501961 rg 5 Ts (note=
) Tj /F1 10 Tf 0 0 0 rg 0 Ts ( we observed.) Tj T* ET=0AQ=0AQ=0Aq=0A1 0 0 1=
 62.69291 675.0236 cm=0Aq=0ABT 1 0 0 1 0 3 Tm 18 TL /F2 15 Tf 0 0 0 rg (How=
 would it benefit the community?) Tj T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 6=
21.0236 cm=0Aq=0A0 0 0 rg=0ABT 1 0 0 1 0 38 Tm /F1 10 Tf 12 TL 2.753314 Tw =
(Google is committed to promoting sustainable development of the community.=
 We hope successful) Tj T* 0 Tw 2.45332 Tw (adoptions of this work will ste=
adily climb over time. To that end, we would be happy to learn your) Tj T* =
0 Tw .289988 Tw (workloads and work with you case by case, and we will do o=
ur best to keep the repo fully maintained. For) Tj T* 0 Tw (those whose wor=
kloads rely on the existing code, we will make sure you will not be affecte=
d in any way.) Tj T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 588.0236 cm=0Aq=0ABT=
 1 0 0 1 0 3.5 Tm 21 TL /F2 17.5 Tf 0 0 0 rg (References) Tj T* ET=0AQ=0AQ=
=0Aq=0A1 0 0 1 62.69291 576.0236 cm=0AQ=0Aq=0A1 0 0 1 62.69291 576.0236 cm=
=0AQ=0Aq=0A1 0 0 1 62.69291 564.0236 cm=0A0 0 0 rg=0ABT /F1 10 Tf 12 TL ET=
=0Aq=0A1 0 0 1 6 -3 cm=0Aq=0A0 0 0 rg=0ABT 1 0 0 1 0 2 Tm /F1 10 Tf 12 TL 5=
=2E66 0 Td (1.) Tj T* -5.66 0 Td ET=0AQ=0AQ=0Aq=0A1 0 0 1 26 -3 cm=0Aq=0ABT=
 1 0 0 1 0 2 Tm 12 TL /F1 10 Tf 0 0 .501961 rg (Long-term SLOs for reclaime=
d cloud computing resources) Tj  T* ET=0AQ=0AQ=0Aq=0AQ=0AQ=0Aq=0A1 0 0 1 62=
=2E69291 558.0236 cm=0AQ=0Aq=0A1 0 0 1 62.69291 546.0236 cm=0A0 0 0 rg=0ABT=
 /F1 10 Tf 12 TL ET=0Aq=0A1 0 0 1 6 -3 cm=0Aq=0A0 0 0 rg=0ABT 1 0 0 1 0 2 T=
m /F1 10 Tf 12 TL 5.66 0 Td (2.) Tj T* -5.66 0 Td ET=0AQ=0AQ=0Aq=0A1 0 0 1 =
26 -3 cm=0Aq=0ABT 1 0 0 1 0 2 Tm 12 TL /F1 10 Tf 0 0 .501961 rg (Profiling =
a warehouse-scale computer) Tj  T* ET=0AQ=0AQ=0Aq=0AQ=0AQ=0Aq=0A1 0 0 1 62.=
69291 540.0236 cm=0AQ=0Aq=0A1 0 0 1 62.69291 528.0236 cm=0A0 0 0 rg=0ABT /F=
1 10 Tf 12 TL ET=0Aq=0A1 0 0 1 6 -3 cm=0Aq=0A0 0 0 rg=0ABT 1 0 0 1 0 2 Tm /=
F1 10 Tf 12 TL 5.66 0 Td (3.) Tj T* -5.66 0 Td ET=0AQ=0AQ=0Aq=0A1 0 0 1 26 =
-3 cm=0Aq=0ABT 1 0 0 1 0 2 Tm 12 TL /F1 10 Tf 0 0 .501961 rg (Evaluation of=
 NUMA-Aware Scheduling in Warehouse-Scale Clusters) Tj  T* ET=0AQ=0AQ=0Aq=
=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 522.0236 cm=0AQ=0Aq=0A1 0 0 1 62.69291 510.=
0236 cm=0A0 0 0 rg=0ABT /F1 10 Tf 12 TL ET=0Aq=0A1 0 0 1 6 -3 cm=0Aq=0A0 0 =
0 rg=0ABT 1 0 0 1 0 2 Tm /F1 10 Tf 12 TL 5.66 0 Td (4.) Tj T* -5.66 0 Td ET=
=0AQ=0AQ=0Aq=0A1 0 0 1 26 -3 cm=0Aq=0ABT 1 0 0 1 0 2 Tm 12 TL /F1 10 Tf 0 0=
 .501961 rg (Software-defined far memory in warehouse-scale computers) Tj  =
T* ET=0AQ=0AQ=0Aq=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 504.0236 cm=0AQ=0Aq=0A1 0 =
0 1 62.69291 492.0236 cm=0A0 0 0 rg=0ABT /F1 10 Tf 12 TL ET=0Aq=0A1 0 0 1 6=
 -3 cm=0Aq=0A0 0 0 rg=0ABT 1 0 0 1 0 2 Tm /F1 10 Tf 12 TL 5.66 0 Td (5.) Tj=
 T* -5.66 0 Td ET=0AQ=0AQ=0Aq=0A1 0 0 1 26 -3 cm=0Aq=0ABT 1 0 0 1 0 2 Tm 12=
 TL /F1 10 Tf 0 0 .501961 rg (Borg: the Next Generation) Tj  T* ET=0AQ=0AQ=
=0Aq=0AQ=0AQ=0Aq=0A1 0 0 1 62.69291 492.0236 cm=0AQ=0Aq=0A1 0 0 1 62.69291 =
435.3307 cm=0AQ=0Aq=0A1 0 0 1 62.69291 406.9843 cm=0An 0 14.17323 m 469.889=
8 14.17323 l S=0AQ=0Aq=0A1 0 0 1 62.69291 394.9843 cm=0A0 0 0 rg=0ABT /F1 1=
0 Tf 12 TL ET=0Aq=0A1 0 0 1 6 0 cm=0Aq=0ABT 1 0 0 1 0 2 Tm 12 TL /F1 10 Tf =
0 0 0 rg (note) Tj T* ET=0AQ=0AQ=0Aq=0A1 0 0 1 91.03937 0 cm=0Aq=0ABT 1 0 0=
 1 0 2 Tm 12 TL /F1 10 Tf 0 0 0 rg (See ) Tj /F3 10 Tf 0 0 0 rg (Documentat=
ion/vm/multigen-lru.rst) Tj /F1 10 Tf 0 0 0 rg ( in the tree.) Tj T* ET=0AQ=
=0AQ=0Aq=0AQ=0AQ=0A =0Aendstream=0Aendobj=0A35 0 obj=0A<<=0A/Nums [ 0 36 0 =
R 1 37 0 R ]=0A>>=0Aendobj=0A36 0 obj=0A<<=0A/S /D /St 1=0A>>=0Aendobj=0A37=
 0 obj=0A<<=0A/S /D /St 2=0A>>=0Aendobj=0Axref=0A0 38=0A0000000000 65535 f =
=0A0000000073 00000 n =0A0000000124 00000 n =0A0000000231 00000 n =0A000000=
0343 00000 n =0A0000000448 00000 n =0A0000000616 00000 n =0A0000000784 0000=
0 n =0A0000000982 00000 n =0A0000001196 00000 n =0A0000001364 00000 n =0A00=
00001533 00000 n =0A0000001788 00000 n =0A0000001957 00000 n =0A0000002148 =
00000 n =0A0000002339 00000 n =0A0000002530 00000 n =0A0000002721 00000 n =
=0A0000002912 00000 n =0A0000003172 00000 n =0A0000003278 00000 n =0A000000=
3558 00000 n =0A0000003633 00000 n =0A0000003746 00000 n =0A0000003872 0000=
0 n =0A0000003997 00000 n =0A0000004116 00000 n =0A0000004273 00000 n =0A00=
00004412 00000 n =0A0000004568 00000 n =0A0000004722 00000 n =0A0000004859 =
00000 n =0A0000004971 00000 n =0A0000005039 00000 n =0A0000010666 00000 n =
=0A0000014326 00000 n =0A0000014376 00000 n =0A0000014410 00000 n =0Atraile=
r=0A<<=0A/ID =0A[<81deae9e7bd716dbc02e05734e1e7696><81deae9e7bd716dbc02e057=
34e1e7696>]=0A% ReportLab generated PDF document -- digest (http://www.repo=
rtlab.com)=0A=0A/Info 20 0 R=0A/Root 19 0 R=0A/Size 38=0A>>=0Astartxref=0A1=
4444=0A%%EOF=0A
--dl73G/axgAFsWD6w--
