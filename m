Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81403B4E67
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 13:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhFZLtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 07:49:35 -0400
Received: from mout.gmx.net ([212.227.17.21]:37529 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbhFZLte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 07:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624708028;
        bh=pPzcNPPUajcUsHa8fgCLCW04NV4QXTj9yvfjp99390g=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=jzxaMDLsURTdiAXZwQWafmWnAMNmedihF40eM64JYUFb/gIWwMHHFJi+qKC1u/NUO
         lhAVx83KLibs6fyQprIlVg7IVcsXNUAe3GLONYaXuvsxTIGuuHwzbJvnLrhATB9yVK
         KoXaKnuYg33g5s53AXD0tTfyYJ4lmfF8Ph1LB2P4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.216.49]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRmjq-1lq4Iw0jFK-00TFtI; Sat, 26
 Jun 2021 13:47:08 +0200
Message-ID: <1c1966dd51ae6f8ddcd892cba485c332281fbd37.camel@gmx.de>
Subject: Re: [ANNOUNCE] rt-tests-2.0
From:   Mike Galbraith <efault@gmx.de>
To:     John Kacur <jkacur@redhat.com>,
        RT <linux-rt-users@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>,
        Johnathan Schwender <schwenderjonathan@gmail.com>,
        Peter Xu <peterx@redhat.com>
Date:   Sat, 26 Jun 2021 13:47:07 +0200
In-Reply-To: <549a4a5579068b9b1ca7741cb0f4aafbd04f4389.camel@gmx.de>
References: <20210625160801.9283-1-jkacur@redhat.com>
         <549a4a5579068b9b1ca7741cb0f4aafbd04f4389.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lT6cLOXI2igBqKXq/ao33/3o43cyJVbPN6UNIwOFaRPpPz8VNx1
 /s5/eWFm9P8LdX3IrOoOUNiVPc6k3lQT3+ZDq5poDXsPkX4jklyASBPXcIJ0LnMAyaRvy9K
 K/nW11fc+I3+qThEKVcziSv3PGawEU/SCNKEV9YOOdZ2qo8urDu+PMkZxTogVsrsWvDNu9U
 gn7xQHGPhHy1dEC5LgpDg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:s45apq3w2mI=:kCDYlhdWmJQhbh6QW+Xsq1
 OcixPakKrBb7XXNZSD6mUoM+L0AbvXF8KNCZ97SzpOCeLZzApZ7xDxrE2xg2+t2gNT4i/OLvf
 YtD/BJoUXeAaQetc2EkamHWeHPJKbMoQia0BNp2bKTZbU3gbwny5lzjkofghsNKUPo2dy4D1r
 bkPX4mQHL3VXpVoRuAJ5mzkvZgE3hjTN0QCrVfMSBAXV7O1EwOP3TIquDV1F0ddE/1Nf//Ds3
 W4n3ryHOvqAGY4aHbe+E8f5VAhGY4jpeMjAxpEUntf/etF35HJid2mh0r22ia6WZ5vYPY1ZEe
 jIpRzqkH9C88zo5vCeukC+h+HljXjkDsrcgIYd9kMg/Dh2XLz1b2l21/JVu0NEkmPBhbybqe1
 x/8TXZtm2SXjjh+FNo2chjx9Zqp6lMLTFzDdvNLE2q5OhViFKUsfSjCFpNSWmCVMRIm2j5ykd
 F8/sNkJbuYwt0BjWyxzj8ELgLnmSzPaK/d+U0Qo1VjIBJKiY3dqq9OfG+kxTAX9yOfXiO8Siz
 0WvoKYNyev0AOax7IMdyIT8HxI25unLifiIYpE8jNy7lVEwnrbO+TXYnH1nlEanVo9hBVnXjv
 b41i95n24trWMHz8eZ161/U+HGCoFstaqAhfBwVVO8TMCTaeJHrmB7phX73tcy501bhHXDjxV
 wjMkWKVG7rnUb4SP6pSMyAfsBJlrrSqY/qEIOHmPap6I5VKXcNwIesj/uq8ZC00o6fQzD9m0/
 T+6lp6FSKXLITR+jEE33VP8kRDRhX0WyMSfIik4gpPnXOBGFHlvh+zHu7oOVQZpPrCtSGywsm
 jld3kLpEkitGSkCvOiKAtqvNxrV6bpWt0QX7BFu1dZUHTn1h+5ZveO8hcW3XDB1VE5tnb0mfB
 sDVG0ddQAhFwB9gqupSTvQzTZVPAtFGfIF1bKzIvz5Komu4cqjOztJKx6FFSLYxm0a7dH9guq
 tWGgPvd+rIU+r9DapUnqzZXaHcQCejsjyRzsZXyxXogMirV40jSoNNNT7K6uBe8eSRBR4DmhF
 sv9E9KDiJsfcNKtMYb5Up/sxxKEgaLzF0woim2E1OEz60YIxNWbTa+Ma2ilnaaLZfIxZetjaf
 UjiEUXG9DuD3o9PCnMbns18LvMcRY9AQ7R1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-06-26 at 08:55 +0200, Mike Galbraith wrote:
> On Fri, 2021-06-25 at 12:08 -0400, John Kacur wrote:
> > I'm pleased to announce rt-tests-2.0
>
> Greetings,
>
> cyclictest seems to have grown an mlock related regression.

Ok, chores done, I did a quick bisect/confirm.  I didn't go stare
at rt_test_start() to ponder what the mlockall connection may be.

426c94e53652b565b0da0410dcad47faef4c23c9 is the first bad commit
commit 426c94e53652b565b0da0410dcad47faef4c23c9
Author: Daniel Wagner <dwagner@suse.de>
Date:   Sat Mar 20 18:28:21 2021 +0100

    cyclictest: Record start of test execution

    Use rt_test_start() to record a timestamp when the test starts.

    Signed-off-by: Daniel Wagner <dwagner@suse.de>
    Signed-off-by: John Kacur <jkacur@redhat.com>

 src/cyclictest/cyclictest.c | 1 +
 1 file changed, 1 insertion(+)

