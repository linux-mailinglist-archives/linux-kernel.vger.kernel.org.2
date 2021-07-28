Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625DF3D90C5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 16:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbhG1Ogl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 10:36:41 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:35179
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235420AbhG1Ogk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 10:36:40 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AsfrdkavvAlJe29v0GNGOiUSv7skDY9V00zEX?=
 =?us-ascii?q?/kB9WHVpmwKj+/xGuM5rtyMc6QxhO03I9urqBEDtexnhHNtOkOws1NSZPDUO2l?=
 =?us-ascii?q?HHEGgK1+KL/9SjIUzDH4VmupuIHZISNOHN?=
X-IronPort-AV: E=Sophos;i="5.84,276,1620684000"; 
   d="scan'208";a="389198213"
Received: from xanadu.blop.info ([178.79.145.134])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 16:36:38 +0200
Date:   Wed, 28 Jul 2021 16:36:31 +0200
From:   Lucas Nussbaum <lucas.nussbaum@inria.fr>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     thomas.lendacky@amd.com, jroedel@suse.de,
        herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org
Subject: Re: [BUG] crypto: ccp: random crashes after kexec on AMD with PSP
 since commit 97f9ac3d
Message-ID: <YQFrb1EWFL2v8mEf@xanadu.blop.info>
References: <YQB3B1RMhPqcrqzW@xanadu.blop.info>
 <20210728133613.28586-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728133613.28586-1-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brijesh,

On 28/07/21 at 08:36 -0500, Brijesh Singh wrote:
> Hi Lucas,
> 
> >On several AMD systems, we see random crashes after kexec, during the
> >boot of the new system (typically 1 out of 5 boots ends up with a
> >crash).
> 
> >According to git bisect, the regression was introduced by commit
> >97f9ac3d ("crypto: ccp - Add support for SEV-ES to the PSP driver"),
> >included since 5.8-rc1. 5.14-rc3 is still affected.
> 
> Can you try the below patch and confirm whether it fixes the random
> crashes seen during the kexec.

I confirm that this fixes the crashes I was seeing.

Tested-by: Lucas Nussbaum <lucas.nussbaum@inria.fr>

Lucas
