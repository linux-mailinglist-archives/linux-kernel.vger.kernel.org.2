Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948053620A7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 15:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbhDPNQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 09:16:53 -0400
Received: from mout.gmx.net ([212.227.17.20]:50811 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234291AbhDPNQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 09:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618578970;
        bh=JtlSzLW8/K5NvlfnH+Ri8+iJvYI5vyc/20pGbd/TO5c=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Hz49Og+hhlKCDAKHIHQPAs8iKdEFM9Dzxnvj/DA6b8Opx1MreHj7UiSPLLpZsLJMD
         bx00NCl8i50aBlJrtFRMp6MNeYajQpffPScYlS3Mrykao9ukJmTdm6uKOf1afhL6+u
         qQYy5IiNE0aEJVsNbEyy9H6IhgUfsWASzGI1a2Qo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.210]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1My36N-1ljhVm3IZr-00zZPh; Fri, 16
 Apr 2021 15:16:09 +0200
Message-ID: <a853ea8535151fd8b267d8e68a45b33748978d8a.camel@gmx.de>
Subject: Re: [patch] x86/crash: fix crash_setup_memmap_entries()
 out-of-bounds access
From:   Mike Galbraith <efault@gmx.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, DaveYoung <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
        x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>
Date:   Fri, 16 Apr 2021 15:16:07 +0200
In-Reply-To: <20210416121636.GA22348@zn.tnic>
References: <9efaad2ba042b8791cbe8c3e7cad491fe05e06eb.camel@gmx.de>
         <20210416110701.GA3835@dhcp-128-65.nay.redhat.com>
         <063a63ddea914ac654cbe9a1d1d6c76986af7882.camel@gmx.de>
         <20210416114708.GB79779@dhcp-128-65.nay.redhat.com>
         <725fa3dc1da2737f0f6188a1a9701bead257ea9d.camel@gmx.de>
         <20210416121636.GA22348@zn.tnic>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hrKSDLXbLMsv+ma/UCoK7fSpC4v+vCIRA+sEiTWH9JPErZSSHYw
 3q8kHmvFVpiwSJ71lWZZP4CsE111jcZAlijIR0XLJUNZjBVje9Iu5svWYxHvHd9q10MTlc/
 BTBCOcE3JIlvdk7igLM8EvpwuV4wsH+whgfbVZORo2yJxoRvgpcA0GgX1gyBqWgh1LsFRwg
 LXeaP7RE/URRv4PQ9m6fQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dnjOaS+w0JQ=:HDfDYAgInv5CYupD4FS6r5
 zXu7V+EXGl7ihAhzYAXPbCgbfAJXYAHnHyFoGPIqne7CRJIxaDDD0N4LnkTKZhDx0KPSHTxvp
 +Tp5kvy8qu34lPhjFJQos/aq/M64iDQz0fQjiFcpTX+nTqqss0QQjcEz492R6N7Ax1j22GKw5
 x+kUXHMoE/L4Jl6xL0SooWG0eXkBTXD+UluiolTkx2VgGZIfA2dI6LN9izUkG4DUA6VWasMod
 dKPYIf09WkTHQymQLa1PrmGb/Ip0ZJe0A44cXNSoLEU0Ue+GOCe6PDQyP0+VYwQzLVvIgOY/D
 BstmaYN1EOxSPpdY3LwjoysHA3PcNk+7eoBSSLE2l8rIA5xek5vCDJKQA637NNq/ddGFHQ/Dc
 sOtCqsHXwXaMs5cnA1EeOuDtj6zVyXJiE5+oiFnPNpCvVhNVeSN2CZjOmtWXah2y2gnO7z7iq
 d+g4fqhTno4YEv0GDZlomHYDgydK0g2nKQ3GN08Yrz7oD5mHBhjn4qYwLvSiwaOApdImMY+mW
 nnTMjIogx+P5glwdbUJQW8CaaRe7A48V7pc/oeW4n3BZrevwVfK0SQwMEA/31vXDaAnSfpOns
 jXf0gqQt3vnCG8//I8CvPU8+kTnMqFEAQjIJZeWJSrk2sjmIzyaGv+0hEYPJX41wMs1lwQ3AV
 XSt6PRxvsIRabfARkaUy0cAEXVQ7MTQgV2ZU5eDO+xkc8qFKXSh3y1mAap8eC28Hl/OxITmSl
 m8lAPRhKYq7ev2sYf8rxq2fe5dT7ZL61P+MRkV9tkYDbwhF0EyvkEPJvE/z54v0STMbL1i8Xf
 3BkEGBj5mcCPgOLiZ0Tu6+ql0tpiQ1Zu9nTRJ7x8bNgTQ7EnkMlItCRboMYPKNwBwts4GaYUO
 pnlGtsVaEbhZagk4B+k7rstLH6h7ooKX4cjn0F9uq+0UXMdn2vMomQN5YOZiRbhEMmpZ1nxM5
 31Z/NKhYKhnSgPJKyEeKop2KLqK0yv1G2zHIeFGjVnn+zKD8BGToRozEs2UvLVT9ct/7Rf7Zt
 hizIhM3k+SxMMQQA2kV1zi1T54FkE2BOPaLqg9Uv+93icLxr1SVHkEwocc0n/3uV92WLmxbVv
 QhprQCq/h7WpgMMVV8j4ofh93QxMyEm9iNKY0QVZLm2M9iGigEWGV/tOUyrDqx45s0FJbX3xQ
 zEhg4C0Ue24ObOcbieQpfqdzAqXAD23RrStqcPM55RvsJoxl1sJMZNmYxNnQtrbQit8fM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-04-16 at 14:16 +0200, Borislav Petkov wrote:
>
> Please be more verbose and structure your commit message like this:

Hrmph, I thought it was too verbose for dinky one-liner if anything.  I
showed the complaint along with an 8x10 color glossy crime scene photo,
then explained why it happened and what to do about it with a perhaps
terse but perfectly clear sentence.

	-Mike

