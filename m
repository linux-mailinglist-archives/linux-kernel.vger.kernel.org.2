Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2DC321426
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 11:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhBVK10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 05:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbhBVK1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 05:27:19 -0500
Received: from filter01-ipv6-out02.totaalholding.nl (filter01-ipv6-out02.totaalholding.nl [IPv6:2a02:40c0:1:2:ffff::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6C7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 02:26:38 -0800 (PST)
Received: from www98.totaalholding.nl ([185.94.230.81])
        by filter01.totaalholding.nl with esmtps (TLSv1.2:AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <mjbaars1977.gcc@cyberfiber.eu>)
        id 1lE7ep-0002dM-RE
        for linux-kernel@vger.kernel.org; Mon, 22 Feb 2021 10:37:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cyberfiber.eu; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uJBoqmb20AESWIZNsJyyi5m2Layyiy5w27GvfUr/XJs=; b=xO4g/dl0dv4jEnuRJOXC0AEzii
        iB5pOMwUKQveAX9ZVa0X7SHiFHDML2UmuXlGjWQK4rqykolab4sEA4n4o/n2rGaFEbUxHapfK311O
        O1dGhu28ddOrl876T/TFxl+HYE31AL0Rk1AScuLmfhmeMbA2vN2qcHPlfjJxoaKcESnA8J0mQ6jyC
        L8Ec8OMAPh6RWDQ0aftk3PM9ahopvl1vJbvDoUBoIfekj9nABJIsPOAkiVQeKXORmndYDQtEhfMfp
        qpuCsllMv4jelONQz3iV8TVR1vxJ3mlB0dd+9zHYizkwsVwgD8w3iHgYXSQuCvDO329xtLlWmU35B
        B3y3Uz+A==;
Received: from 82-94-23-232.ip.xs4all.nl ([82.94.23.232]:48582 helo=tp06.long4more.com)
        by www98.totaalholding.nl with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <mjbaars1977.gcc@cyberfiber.eu>)
        id 1lE7em-0006qG-O4; Mon, 22 Feb 2021 10:37:32 +0100
Message-ID: <d9a2cdcf116ed32874ed02bd6fa60ad899ce5f50.camel@cyberfiber.eu>
Subject: Re: problems with memory allocation and the alignment check
From:   "Michael J. Baars" <mjbaars1977.gcc@cyberfiber.eu>
To:     Andrew Pinski <pinskia@gmail.com>
Cc:     GCC Mailing List <gcc@gcc.gnu.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 22 Feb 2021 10:37:33 +0100
In-Reply-To: <CA+=Sn1njFZ-XZRHJdmjzOyvXvcMXg+oBao=wK8w3RXN_Ji=fLA@mail.gmail.com>
References: <80753cbc54ef69b4fc136f791666197fc8b1f8bb.camel@cyberfiber.eu>
         <CA+=Sn1njFZ-XZRHJdmjzOyvXvcMXg+oBao=wK8w3RXN_Ji=fLA@mail.gmail.com>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.10)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT86LOCQny59ksdOdRHzCf5PPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5z4WkZ/TJaiaBbP2NJqrVHtfCzdNGNoLjYW00m5NbCHvI9w
 knWGobBIYos3d1n2bRGguWCSRiV4Egg0CI/eXxnF5WCy5VkstzhnxgTXqsdmpzAZsc6MRuL9DcHa
 Zpd4we/piBIbZdykCKL9bqvChryU+RG6hze7zJVTSRhy6iTC2HkixtWJU3ux8TqCslrbPB+bgaCk
 W8nGm/sYr5TGcUrdU3OqTzTj50M7fvGTHKtUfcFSHlWCaM2L0TajYf48Pb86t/uXZsD0kV3eTzZp
 3NyQLDnQGgRgHjioU8fpt7xeC7AK0L/uTNt3WCw41GzGb1Zq+pu9ho29CVyp3Dt9A9c5Q0rCcBHa
 hWKxj5ucSpYIqLmSWYrW9rfAlJyD3amD/+N02lc/+6URXoMhQMtzRh3qJOVgT5lyfynWs+kbrg/X
 Ljy6H8ZAD1knk8QPx5GWwsxL96o2cJJSAqZrdlwt8BT+rl/L3p68qpY0qoWMExIKqSSxWVdlbFqx
 F8WMzybyHsghJ1UrIDz/zIKkhjMfdql/vyG/94A9cXb+Do2HsRTe4iHS0NxcLTrnItRtF3glL8Fz
 lRYBdrHtfAxZw42LBRK8JPpUwLRS/j55N5WCkBFDwy25y0VVCnTvyy8sSoe9MJmYQRPlfhUIsQHw
 9jJ1gs4A07pSUabTJxCHRiVu3X4RqvdjzQ6YC7Heg3Xf7O1TOd4ek3v5uIRk1iKw5Fn4+Jv37dfW
 alqFj9toMieTbX1rTptKDSCSE1jQS4xT8YHigtq8kLcbHwp89REWDGmTSXlzZuM7jUXIESohoO51
 xWmU8ZsLPNyWKRVhd4Yc6cD23FynV0BR+dlWoGfFQ+S+p4Yps+5OVLTtd9bM4QLzoum6fo2azxuH
 F97acinCSKJAyH+R27r9HYUzziTFhEVK8LUgzbwe5wJ+PSAukJcp0I0jTu0aTq8ZhiCjAOP7kbHh
 TW8wbVA/fmexh8/zhz5EUrcqADujzMmWyPJKS+6kHMEcy2SSgL4U/904QKV4vLt8ilQ=
X-Report-Abuse-To: spam@filter01.totaalholding.nl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-02-22 at 01:29 -0800, Andrew Pinski wrote:
> On Mon, Feb 22, 2021 at 1:17 AM Michael J. Baars
> <mjbaars1977.gcc@cyberfiber.eu> wrote:
> > Hi,
> > 
> > I just wrote this little program to demonstrate a possible flaw in both malloc and calloc.
> > 
> > If I allocate a the simplest memory region from main(), one out of three optimization flags fail.
> > If I allocate the same region from a function, three out of three optimization flags fail.
> > 
> > Does someone know if this really is a flaw, and if so, is it a gcc or a kernel flaw?
> 
> There is no flaw.  GCC (kernel, glibc) all assume unaligned accesses
> on x86 will not cause an exception.

Is this just an assumption or more like a fact? I agree with you that byte aligned is more or less the same as unaligned.

> 
> Thanks,
> Andrew
> 
> > Regards,
> > Mischa.

