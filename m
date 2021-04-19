Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8093A364EE7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 01:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbhDSX6Q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Apr 2021 19:58:16 -0400
Received: from zimbra.cs.ucla.edu ([131.179.128.68]:34768 "EHLO
        zimbra.cs.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbhDSX6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 19:58:15 -0400
X-Greylist: delayed 333 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Apr 2021 19:58:15 EDT
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id C282916005F;
        Mon, 19 Apr 2021 16:52:11 -0700 (PDT)
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id R4ycixmGNAYj; Mon, 19 Apr 2021 16:52:10 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id D2E1416013B;
        Mon, 19 Apr 2021 16:52:10 -0700 (PDT)
X-Virus-Scanned: amavisd-new at zimbra.cs.ucla.edu
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ghCC6ODsdtTb; Mon, 19 Apr 2021 16:52:10 -0700 (PDT)
Received: from [192.168.1.9] (cpe-172-91-119-151.socal.res.rr.com [172.91.119.151])
        by zimbra.cs.ucla.edu (Postfix) with ESMTPSA id 6DC4D16005F;
        Mon, 19 Apr 2021 16:52:10 -0700 (PDT)
To:     Len Brown <lenb@kernel.org>
Cc:     Florian Weimer <fweimer@redhat.com>, linux-abi@vger.kernel.org,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kyle Huey <me@kylehuey.com>, Rich Felker <dalias@libc.org>,
        Andy Lutomirski <luto@kernel.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Willy Tarreau <w@1wt.eu>, Borislav Petkov <bp@alien8.de>
References: <20210413034346.GA22861@1wt.eu>
 <CAJvTdKmLth==ZPv7ygLs0jFX7JRPVhVT82ZDoT4xcQRABEVTvQ@mail.gmail.com>
 <20210414095804.GB10709@zn.tnic>
 <CAJvTdKn_y8qAjDy189zEf8cnaWrvW3baca=z9FgGxV9AvQEADg@mail.gmail.com>
 <20210415044258.GA6318@zn.tnic> <20210415052938.GA2325@1wt.eu>
 <20210415054713.GB6318@zn.tnic>
 <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com>
 <20210419141454.GE9093@zn.tnic>
 <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com>
 <20210419191539.GH9093@zn.tnic>
 <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com>
From:   Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related
 features
Message-ID: <1af4c589-f79b-6766-329e-74c735c17376@cs.ucla.edu>
Date:   Mon, 19 Apr 2021 16:52:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/21 2:33 PM, Len Brown via Libc-alpha wrote:
> the AI guys are super excited about matrix multiplication,
> but I have a hard time imagining why grep(1) would find a use for it.

I don't. Matrix multiplication is used in modern string-searching 
algorithms that could be useful in running 'grep' on CPUs that have 
relevant hardware support. See, for example:

Susanina Y, Yaveyn A, Grigorev S. Modification of Valiant’s Parsing 
Algorithm for the String-Searching Problem. CIBB 2019. 
https://doi.org/10.1007/978-3-030-63061-4_17

Although nowadays this technology is typically proposed for 
bioinformatics (DNA pattern matching, etc.), it's not that much of a 
stretch to imagine a future 'grep' or 'diff' that does matrix 
multiplication. After all, GNU 'diff' currently uses an algorithm 
designed by a DNA expert.

(We now return you to the regular AMX debates. :-)
