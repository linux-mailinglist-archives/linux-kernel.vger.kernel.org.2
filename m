Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B40411060
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 09:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbhITHnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 03:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbhITHnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 03:43:52 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7069C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 00:42:25 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z24so37653300lfu.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 00:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w0P3ciU7DNO/LgT6fxR07gqx6gx1yZdqF147JHefD4Y=;
        b=OEDTd233SJIwx38XJOgHFnuo6Xcqu16j3x+ehNCfReRDbDfG4o+v+eDVmSgSuXDhqF
         GqMNucDj1HEA/zsQMNKtDo0P23d8l2Q0C4MUxNlsTsA8TjwYWxJWAqQl4Q42ogVKS6Re
         Ny7eEFibxtOvkfsUpSeEFjAFmJLNYyZ09JerE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w0P3ciU7DNO/LgT6fxR07gqx6gx1yZdqF147JHefD4Y=;
        b=cprmR3tWnBFUEWOQBtYivBYxaSWZ6XOtRi3fA1+Yvf94P4LyALps9CgAQDb4bgmseT
         SRRb/ovyMfdBhqn8pWgqySV5r7ZOf7sRzp0LTOuotoExfLrvNDlLm/ZY9FYieL+bHovJ
         cLnd/OVSABHrMErDwbJ1hR+TRycC0tA8980asakLGlnIsyQalmh7wxZi0qlPFG3f4m3h
         MSXa+IblXabWBJvXpSA0BhXgH4WAsWP+a7tIcna6AxiVpFzEu5b94efHC+9rrgsMfhUv
         Noa9atyogc78J4iUNmDGlYLn3javnI2ZQI2GfV4/O0mEK/uCxMio2EskGIEAvePCGwVd
         OF6g==
X-Gm-Message-State: AOAM531ihc2q2q5COijGLVxpIaOja0TJSNEywNk2QFVQ1oT79J7RcH7n
        0B+k7zJ/N8qOuiOAXMPyz3Vns0ZMHyzDCsRx
X-Google-Smtp-Source: ABdhPJw6oYfM7AGf5zpeZWvWCF0cjlxHYKDu+xTCy4nLuAB+ERY0Pzom+1S3zKb0owZ15voFlbr5UA==
X-Received: by 2002:a2e:1508:: with SMTP id s8mr21564383ljd.47.1632123743905;
        Mon, 20 Sep 2021 00:42:23 -0700 (PDT)
Received: from [172.16.11.1] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f37sm1195187lfv.214.2021.09.20.00.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 00:42:23 -0700 (PDT)
Subject: Re: [PATCH 2/4] x86/mce: Get rid of machine_check_vector
To:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210917105355.2368-1-bp@alien8.de>
 <20210917105355.2368-3-bp@alien8.de>
 <YUgUpXHciLMn4X20@agluck-desk2.amr.corp.intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <5eb3ac0a-4887-08b2-82fa-0348e04ace95@rasmusvillemoes.dk>
Date:   Mon, 20 Sep 2021 09:42:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YUgUpXHciLMn4X20@agluck-desk2.amr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2021 06.57, Luck, Tony wrote:
> On Fri, Sep 17, 2021 at 12:53:53PM +0200, Borislav Petkov wrote:
>> @@ -126,7 +123,9 @@ struct mca_config {
>>  	      ser			: 1,
>>  	      recovery			: 1,
>>  	      bios_cmci_threshold	: 1,
>> -	      __reserved		: 59;
>> +	      /* Proper #MC exception handler is set */
>> +	      initialized		: 1,
>> +	      __reserved		: 58;
> 
> Does this __reserved field do anything useful? It seems to
> just be an annoyance that must be updated each time a new
> bit is added. Surely the compiler will see that these bitfields
> are in a "u64" and do the math and skip to the right boundary
> without this.

Not at all. And it also seems that the current layout is not at all what
may have been intended (the bit fields do not start at an 8-byte boundary).

$ cat a.c
#include <string.h>
#include <stdint.h>
struct s1 {
        char x;
        uint64_t a:1,
                 b:1,
                 c:1,
                 d:61;
        char y;
};
struct s2 {
        char x;
        uint64_t a:1,
                 b:1,
                 c:1;
        char y;
};
struct s3 {
        uint64_t x;
        uint64_t a:1,
                 b:1,
                 c:1;
        char y;
};
// some dummy functions to make the structs appear used and make gcc
// actually emit debug info
void f1(struct s1 *s) { memset(s, 0xff, sizeof(*s)); }
void f2(struct s2 *s) { memset(s, 0xff, sizeof(*s)); }
void f3(struct s3 *s) { memset(s, 0xff, sizeof(*s)); }
$ gcc -o a.o -c a.c -O2 -g
$ pahole a.o
struct s1 {
    char                x;                    /*     0     1 */

    /* Bitfield combined with previous fields */

    uint64_t            a:1;                  /*     0: 8  8 */
    uint64_t            b:1;                  /*     0: 9  8 */
    uint64_t            c:1;                  /*     0:10  8 */

    /* XXX 53 bits hole, try to pack */

    /* Force alignment to the next boundary: */
    uint64_t            :0;

    uint64_t            d:61;                 /*     8: 0  8 */

    /* XXX 3 bits hole, try to pack */

    char                y;                    /*    16     1 */

    /* size: 24, cachelines: 1, members: 6 */
    /* sum members: 2 */
    /* sum bitfield members: 64 bits, bit holes: 2, sum bit holes: 56
bits */
    /* padding: 7 */
    /* last cacheline: 24 bytes */
};
struct s2 {
    char                x;                    /*     0     1 */

    /* Bitfield combined with previous fields */

    uint64_t            a:1;                  /*     0: 8  8 */
    uint64_t            b:1;                  /*     0: 9  8 */
    uint64_t            c:1;                  /*     0:10  8 */

    /* XXX 5 bits hole, try to pack */
    /* Bitfield combined with next fields */

    char                y;                    /*     2     1 */

    /* size: 8, cachelines: 1, members: 5 */
    /* sum members: 2 */
    /* sum bitfield members: 3 bits, bit holes: 1, sum bit holes: 5 bits */
    /* padding: 5 */
    /* last cacheline: 8 bytes */
};
struct s3 {
    uint64_t            x;                    /*     0     8 */
    uint64_t            a:1;                  /*     8: 0  8 */
    uint64_t            b:1;                  /*     8: 1  8 */
    uint64_t            c:1;                  /*     8: 2  8 */

    /* XXX 5 bits hole, try to pack */
    /* Bitfield combined with next fields */

    char                y;                    /*     9     1 */

    /* size: 16, cachelines: 1, members: 5 */
    /* sum members: 9 */
    /* sum bitfield members: 3 bits, bit holes: 1, sum bit holes: 5 bits */
    /* padding: 6 */
    /* last cacheline: 16 bytes */
};

And, since in the concrete case mca_config just has four bool members
before the bitfields, we see that the 1-bit bitfields are put within the
first 8 bytes of the struct, while the __reserved field gets an entire
u64 all to itself:

struct mca_config {
    _Bool               dont_log_ce;          /*     0     1 */
    _Bool               cmci_disabled;        /*     1     1 */
    _Bool               ignore_ce;            /*     2     1 */
    _Bool               print_all;            /*     3     1 */

    /* Bitfield combined with previous fields */

    long long unsigned int     lmce_disabled:1;      /*     0:32  8 */
    long long unsigned int     disabled:1;    /*     0:33  8 */
    long long unsigned int     ser:1;         /*     0:34  8 */
    long long unsigned int     recovery:1;    /*     0:35  8 */
    long long unsigned int     bios_cmci_threshold:1; /*     0:36  8 */

    /* XXX 27 bits hole, try to pack */

    /* Force alignment to the next boundary: */
    long long unsigned int     :0;

    long long unsigned int     __reserved:59;        /*     8: 0  8 */

    /* XXX 5 bits hole, try to pack */

    signed char         bootlog;              /*    16     1 */

    /* XXX 3 bytes hole, try to pack */

    int                 tolerant;             /*    20     4 */
    int                 monarch_timeout;      /*    24     4 */
    int                 panic_timeout;        /*    28     4 */
    unsigned int        rip_msr;              /*    32     4 */

    /* size: 40, cachelines: 1, members: 15 */
    /* sum members: 21, holes: 1, sum holes: 3 */
    /* sum bitfield members: 64 bits, bit holes: 2, sum bit holes: 32
bits */
    /* padding: 4 */
    /* last cacheline: 40 bytes */
};

But why the messy mix between 1-bit bitfields and _Bools in the first place?

Rasmus
