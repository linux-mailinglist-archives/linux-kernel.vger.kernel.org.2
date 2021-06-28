Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A503B5881
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 07:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhF1FKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 01:10:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:36731 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhF1FKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 01:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624856891;
        bh=p4NyXCslf/2NNSWvkidrJjQDtMBO2qbsRymu1UVAzTo=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=UfbdPPEsx6jX+Sk2ftWHKRsykLFH7uYC5tfEtli4gDu+UqAmprMZPfoQOT997ndG3
         1/f+Hc7odQjXdUaWg0c2VI3abKU8FoidrwbiIY4AlkAnXwnywNrTn4HBICyN1jOhDF
         yd0ou+PclnmWPRT+ggpYmap960Q5O5JtAK2CMVy8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.151.107]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxUnz-1l06Wx2oo5-00xwDP; Mon, 28
 Jun 2021 07:08:10 +0200
Message-ID: <9e57eba845860ec1bc613478b62734b678310fa2.camel@gmx.de>
Subject: Re: drm/nouveau: lockdep circular locking dependency report
From:   Mike Galbraith <efault@gmx.de>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Ben Skeggs <bskeggs@redhat.com>,
        nouveau <nouveau@lists.freedesktop.org>
Date:   Mon, 28 Jun 2021 07:08:10 +0200
In-Reply-To: <f3cb7efc616be532ab2dc9f3ac2e8611dd643888.camel@gmx.de>
References: <f3cb7efc616be532ab2dc9f3ac2e8611dd643888.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:E+6AU6Qt5ySmV7t1Tfx6olcMt6iU91fFVtD8qMcCMNx50Mjx3Y4
 eAc6W12nOttRYjTDfVYy1o7xlO/HqmeX3b6ja02+DNtu2WjR7w+7O9RcWtwksyYmLRj9Q+M
 09D0IIOyAxQnPNrHDBPk8WvDsBgd6n7v8L6kKlnuPmsh9znedK/fCs3cFT6e1kcpy7KwTsk
 ieAWhf138rQpu7ibUC1QA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:87ZEwFSkFbg=:kcyJ9xa6QiU/L8OnGx/j5U
 zRDIdtOKZQjrsx1DfUdk+ABEFg0DTX9eK6BGccJF+Kmd6sc2bbcJKYMjcQaY0+NzKZfoNGRMw
 4qjarypuesP4pJ3ZL0Gx1NbYKqw66qOS3RQO1qY5svZKBUjoqPyMA/NtgpLQsOJR18MGGTZsQ
 xKdJeuYvyCmRb6kYi9BAeUNocPNEwXxWTnBcFnQgIJFiLVZIRNrBrd9wzZM1TdiZZHOM1vs2s
 xvHEDyyuswaMP3W5f2WaoyIOuBk0Q3pjxjCX7HLpBSxPaCXTrV1JUbOTHFPkshlZYRPUGzZAk
 pDqCa14bxH9TwCy8JOpgSZQ12VPrxAlSvlNThjLhralmFWOY9XTdaeCfDF00vCWzW+phH0KbV
 wL+naTmKF+FoJXACtdP2hwJiA/pUZflDv641C1XlpC60B97LNX5/IFTeUn4750v/yp9BBU6PQ
 pLcl4ldcnQvBzYbbTUjNx5hXBKMV/Ee9mzCs6agQbupRhOT+6yDibNTaJCXyoaMWzBSIokciy
 yo3HcWMjwSg9Q/IiYr8t90HrdkPUuPugNLZNKIOmGlYaYoQHcdnN4fcFn2WE6M6EO9Z3VPYJk
 X0xs4KUg8rs0Joe2I9VuPMzdhG+94wgEP8olefYkruE0CeTW/bmnDDgt9TXGWdrH4m0BAcWHY
 XG/bWNGVeK8eUGyQFz0zBMaGAFsiGNYZVTmPVD/Ay4+bZlXZkPOx2ajilDo4EPCHEfwJ+4bxn
 /jj5bTHzRKI0cgAMYPBeXAFakQ103+QHfIL/4r9BTRxOIjHrg9GVWCgAiFgI/KZCX8vxvVUeC
 JnbOrTl0w+DW6bq1eQ5GV80ierDGgjySoclXKev++1xDtPLDkjpUypbR0pcJhfm6p2cNl82yC
 rLS2YYwBFgRVZNhdAPj67cto2ZS3iEiNxe2BiHLYW4mVMB5NJfPgOWyvIu5V6IBt0dZebmTwc
 g8Iv9XY0p1KVZUWJ/cxd+7wf+yH2ZiW04fjhg2yL0V9saP4+HEtCwH6mzLeAM39DDe6gFNC/K
 6+UfxHeKQnnVPNqvBuvqhJycU/G5y57QiqLcblIDU+sZsxOI/8NKnDu2ZQ/gRD7uzhUpVWN0C
 ZZ5YhV62UPwT7CfTDtcQQFTtmB3AcQNUdoB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've now applied a revert of 551620f2a3816397266dfd812cd8b3be89f14be4
to all trees where lockdep may be enabled to re-hide the inversion.  It
thus won't every remind me of its existence, thus I won't be inspired
to pass that reminder along.

	-Mike

