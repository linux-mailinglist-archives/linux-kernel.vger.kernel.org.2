Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF1E3A31C7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 19:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhFJRNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 13:13:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229802AbhFJRNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 13:13:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C289613C9;
        Thu, 10 Jun 2021 17:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623345080;
        bh=5i1YYQPe0SKOHI2nfgnCq6FvKp5HQINwp673ARQ1VXM=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=sZLYDAkzceQzmHC8j1hrcOsy4f5x6gHdtTEbmkpg8MoRNEu9XCYJkIDM2/bHTVeI0
         6irbV3NMp/06UEtvUSVSTK4C37F0xD9yI4TL3GN2WPhftgeIgf1IZNE760YDpU/tkD
         hjBHLXWtWh3dKTUuVs0YLqGNn0zKd8ERO94g1G9axxNSKBuQGy34iT4FsPI6bd2w7a
         IpaMZ9zVMo86HXa4YNBCeGlUMD8CtcipbYvNAHAjqZpH/hlsBocU1fOlet7VKvhUnt
         OR574b3hy7Z2HH49kw3x+E+4legwFjHGX2/YDjT6JqMwXEb0sGjbiOtzQPGQ5XLVpp
         tgFL4F+4rCN7w==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id A622027C005A;
        Thu, 10 Jun 2021 13:11:18 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute2.internal (MEProxy); Thu, 10 Jun 2021 13:11:18 -0400
X-ME-Sender: <xms:tEfCYAkCygQ17ogjTQTpay2ewKtC920hX-Fiv0qpyYENRVKY6ybqCw>
    <xme:tEfCYP0PGX7P5Be8vbtLotgJtAy5FuRy9nbn2mxOvCCvh0dce0w7NsWPJHSD9izSv
    FmwlngHcpzthO2jfhc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedufedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvleehjeejvefhuddtgeegffdtjedtffegveethedvgfejieev
    ieeufeevuedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:tEfCYOp0pU9BgDyRti454DjWmvRh0_zcUEA1jTYT_hLk3xZFk1cqhA>
    <xmx:tEfCYMlvGIn00t_9cZHUDQokpCAfzzQTKEwj_0Ij4wKBD6exN940NQ>
    <xmx:tEfCYO3yZeuRGfmv94NLqkQXEyVSb89LAdIJc9pltBhLmljhKs_8Dg>
    <xmx:tkfCYHmTikck1C3cZBxLLX-6xeC9vy5OaeNY694m8PmXKwKk5_pjjkLwlno>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8673251C0060; Thu, 10 Jun 2021 13:11:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-519-g27a961944e-fm-20210531.001-g27a96194
Mime-Version: 1.0
Message-Id: <ca2d7f44-bbef-448a-bbd4-ff27cc6f0c9e@www.fastmail.com>
In-Reply-To: <20210608144345.912645927@linutronix.de>
References: <20210608143617.565868844@linutronix.de>
 <20210608144345.912645927@linutronix.de>
Date:   Thu, 10 Jun 2021 10:10:51 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Fenghua Yu" <fenghua.yu@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
        "Rik van Riel" <riel@surriel.com>, "Borislav Petkov" <bp@suse.de>
Subject: =?UTF-8?Q?Re:_[patch_V3_3/6]_x86/process:_Check_PF=5FKTHREAD_and_not_cur?=
 =?UTF-8?Q?rent->mm_for_kernel_threads?=
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Jun 8, 2021, at 7:36 AM, Thomas Gleixner wrote:
> switch_fpu_finish() checks current->mm as indicator for kernel threads=
.
> That's wrong because kernel threads can temporarily use a mm of a user=

> process via kthread_use_mm().
>=20
> Check the task flags for PF_KTHREAD instead.
>=20
> Fixes: 0cecca9d03c9 ("x86/fpu: Eager switch PKRU state")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/x86/include/asm/fpu/internal.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -578,7 +578,7 @@ static inline void switch_fpu_finish(str
>  	 * PKRU state is switched eagerly because it needs to be valid befor=
e we
>  	 * return to userland e.g. for a copy_to_user() operation.
>  	 */
> -	if (current->mm) {
> +	if (!(current->flags & PF_KTHREAD)) {
>  		pk =3D get_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
>  		if (pk)
>  			pkru_val =3D pk->pkru;
>=20
>=20

Why are we checking this at all?  I actually tend to agree with the ->mm=
 check more than PF_anything. If we have a user address space, then PKRU=
 matters. If we don=E2=80=99t, then it doesn=E2=80=99t.
