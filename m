Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEEB3213C3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 11:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhBVKIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 05:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhBVKF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 05:05:29 -0500
X-Greylist: delayed 1629 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 Feb 2021 02:04:48 PST
Received: from filter01-ipv6-out08.totaalholding.nl (filter01-ipv6-out08.totaalholding.nl [IPv6:2a02:40c0:1:2:ffff::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC437C061793
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 02:04:48 -0800 (PST)
Received: from www98.totaalholding.nl ([185.94.230.81])
        by filter01.totaalholding.nl with esmtps (TLSv1.2:AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <mjbaars1977.gcc@cyberfiber.eu>)
        id 1lE852-00014S-SP
        for linux-kernel@vger.kernel.org; Mon, 22 Feb 2021 11:04:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cyberfiber.eu; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6rt4rAP4w0ppViWQHMVPSZJynj22nNKL1wg8xgcmFfk=; b=gP+bXSyiIVHt8aHmNdANKzNj4S
        oak43WAUPTJJuNIiL61NNK4PR3HR/xb3V0fCJAI87QwV57NOF6LzCqLZYZ94A5Q9D5BvqOL7AruuO
        RroD+N401cWNZbs/4hsfNOqv664HE6tuS2oBdOyFZc05RVM7QKJ77/rIvFCZag5jX0/L520MWjbPd
        sKZ4BK8JG3su3y76fhof0SLTHLVGze3OXYl/18WP8GLSfQ5jrm0Efn9XqGHJX2xAB24cXR4yHABdW
        dv0c76xtYYS/jVqZq1oNmdp5nb0OMvxjuX4rZjDxI2JHF/eEbcEzLUIKG9g4wqQ1IGmFJdqVlA0Ro
        /NGfysDQ==;
Received: from 82-94-23-232.ip.xs4all.nl ([82.94.23.232]:54910 helo=tp06.long4more.com)
        by www98.totaalholding.nl with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <mjbaars1977.gcc@cyberfiber.eu>)
        id 1lE851-00027R-EF; Mon, 22 Feb 2021 11:04:39 +0100
Message-ID: <64755104869ec3af730db147b5eccb5da4b78b74.camel@cyberfiber.eu>
Subject: Re: problems with memory allocation and the alignment check
From:   "Michael J. Baars" <mjbaars1977.gcc@cyberfiber.eu>
To:     Andrew Pinski <pinskia@gmail.com>
Cc:     GCC Mailing List <gcc@gcc.gnu.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 22 Feb 2021 11:04:40 +0100
In-Reply-To: <CA+=Sn1kR6jV2j2cOLhC-GBDS_NSxsw0m=K+VghBmqBSB4c2gqw@mail.gmail.com>
References: <80753cbc54ef69b4fc136f791666197fc8b1f8bb.camel@cyberfiber.eu>
         <CA+=Sn1njFZ-XZRHJdmjzOyvXvcMXg+oBao=wK8w3RXN_Ji=fLA@mail.gmail.com>
         <d9a2cdcf116ed32874ed02bd6fa60ad899ce5f50.camel@cyberfiber.eu>
         <CA+=Sn1kR6jV2j2cOLhC-GBDS_NSxsw0m=K+VghBmqBSB4c2gqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - www98.totaalholding.nl
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - cyberfiber.eu
X-Get-Message-Sender-Via: www98.totaalholding.nl: authenticated_id: mjbaars1977.gcc@cyberfiber.eu
X-Authenticated-Sender: www98.totaalholding.nl: mjbaars1977.gcc@cyberfiber.eu
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Originating-IP: 185.94.230.81
X-SpamExperts-Domain: out.totaalholding.nl
X-SpamExperts-Username: 185.94.230.81
Authentication-Results: totaalholding.nl; auth=pass smtp.auth=185.94.230.81@out.totaalholding.nl
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.11)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT/mDSGpZbTUMXuqHprC2CKRPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5z4WkZ/TJaiaBbP2NJqrVHtfCzdNGNoLjYW00m5NbCHvI9w
 knWGobBIYos3d1n2bRFrr7MFgLsNQjVehl0AjLQh5WCy5VkstzhnxgTXqsdmpzAZsc6MRuL9DcHa
 Zpd4we/piBIbZdykCKL9bqvChryU+RG6hze7zJVTSRhy6iTC2HkixtWJU3ux8TqCslrbPB+bgaCk
 W8nGm/sYr5TGcUrdU3OqTzTj50M7fvGTHKtUfcFSHlWCaM2L0TajYf48Pb86t/uXZsD0kV3eTzZp
 3NyQLDnQGgRgHjioU8fpt7xeC7AK0L/uTNt3WCw41GzGb1Zq+pu9ho29CVyp3Dt9A9c5Q0rCcBHa
 hWKxj5ucSpYIqLmSWYrW9rfAlJyD3amD/+N02lc/+6URXoMhQMtzRh3qJOVgT5lyfynWs+kbrg/X
 Ljy6H8ZAD1knk8QPx5GWwsxL96o2cJJSAqZrdlwt8BT+rl/L3p68qpY0qoWMExIKqSSxWVdlbFqx
 F8WMzybyHsghJ1UrIDz/zIKkhjMfdql/vyG/94A9cXb+Do2HsRTe4iHS0NxcLTrnItRtF3glL8Fz
 lRYBdrHtfAxZw42LBRK8o5yWOEmvMm4n8TJQn6xbOS25y0VVCnTvyy8sSoe9MJmYQRPlfhUIsQHw
 9jJ1gs4A07pSUabTJxCHRiVu3X4RqvdjzQ6YC7Heg3Xf7O1TOd4ek3v5uIRk1iKw5Fn4+Jv37dfW
 alqFj9toMieTbX1rTmoGyi3gpIwXr8e2QN5OEu6dT4kzjylMZ8WxooKJmgvqZuM7jUXIESohoO51
 xWmU8ZsLPNyWKRVhd4Yc6cD23FynV0BR+dlWoGfFQ+S+p4Yps+5OVLTtd9bM4QLzoum6fo2azxuH
 F97acinCSKJAyH+R27r9HYUzziTFhEVK8LUgzbwe5wJ+PSAukJcp0I0jTu0aTq8ZhiCjAOP7kbHh
 TW8wbVA/fmexh8/zhz5EUrcqADujzMmWyPJKS+6kHMEcy2SSgL4U/904QKV4vLt8ilQ=
X-Report-Abuse-To: spam@filter01.totaalholding.nl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-02-22 at 01:41 -0800, Andrew Pinski wrote:
> On Mon, Feb 22, 2021 at 1:37 AM Michael J. Baars
> <mjbaars1977.gcc@cyberfiber.eu> wrote:
> > On Mon, 2021-02-22 at 01:29 -0800, Andrew Pinski wrote:
> > > On Mon, Feb 22, 2021 at 1:17 AM Michael J. Baars
> > > <mjbaars1977.gcc@cyberfiber.eu> wrote:
> > > > Hi,
> > > > 
> > > > I just wrote this little program to demonstrate a possible flaw in both malloc and calloc.
> > > > 
> > > > If I allocate a the simplest memory region from main(), one out of three optimization flags fail.
> > > > If I allocate the same region from a function, three out of three optimization flags fail.
> > > > 
> > > > Does someone know if this really is a flaw, and if so, is it a gcc or a kernel flaw?
> > > 
> > > There is no flaw.  GCC (kernel, glibc) all assume unaligned accesses
> > > on x86 will not cause an exception.
> > 
> > Is this just an assumption or more like a fact? I agree with you that byte aligned is more or less the same as unaligned.
> 
> It is an assumption that is even made inside GCC.  You can modify GCC
> not to assume that but you need to recompile all libraries and even
> check the assembly code that is included with most programs.
> Why are you enabling the alignment access check anyways?  What are you
> trying to do?

I'm writing an algorithm to compress and encrypt data for use in cluster computing. While trying to verify my own code, I stumbled upon this. Just like that...

And yes, as always performance certainly is an issue :) Correctness of the code even more.

> If you are looking into a performance issue with unaligned accesses,
> may I suggest you look into perf to see if you can see unaligned
> accesses?

So it's more like a joke than a flaw? I noticed it earlier with printf too, and traced it back to the strlen kernel assembly code where a lot of sse code is
used that expects memory to be aligned at the 16 byte boundary. Most character strings that come with printf as an argument, apparently aren't.

I'll have a look at perf.

> 
> Thanks,
> Andrew
> 
> > > Thanks,
> > > Andrew
> > > 
> > > > Regards,
> > > > Mischa.



