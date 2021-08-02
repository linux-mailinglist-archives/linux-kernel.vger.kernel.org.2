Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8AA83DE21B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 00:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhHBWJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 18:09:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231950AbhHBWJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 18:09:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5284260E78;
        Mon,  2 Aug 2021 22:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627942159;
        bh=fLVQF/t6wPWp+qJ9ehM/MjUmrMCRd15NX4dAGPwnH68=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JnPV96lgFzoQstMQbGsvksvar5yILQC1BQO2UksHvxMQiepiHEnWO9xePi+uK9v0z
         WFRVrFzTzlg2ctvNmaenXiFfqBK3FJV24+CgCmDs/4StoUIIwCuKy8390REyGA11Xm
         nTxIop+8V2RlOB0IhEj8yCiyVvu/1j5Qh+F1WCOJ/DH0mTv0Lk2R9hRrSYTHMY8XhW
         RYOheQ3Dhf439zEG09uNyGr+vQ3sOzy9XnHS6ozSL3ayUqoFSKPQn8uapzTLa4FmbN
         ZsMirZ/JMBRfzYHmdJX7gc+oI5r+S2Q2XpM0B0Wg20G2eJ1Wwkl69+BL6B6THFmQ2b
         35bWXI8U/pylQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1371790418.70998.1627846630234@mail1.libero.it>
References: <20210725160725.10788-1-dariobin@libero.it> <CAPTRvHkf0cK_4ZidM17rPo99gWDmxgqFt4CDUjqFFwkOeQeFDg@mail.gmail.com> <1926284813.753014.1627553002984@mail1.libero.it> <CAPTRvH=R822osk86tRJqJCPNYY85t8t90+HJWcz43iASbcg2Jw@mail.gmail.com> <1371790418.70998.1627846630234@mail1.libero.it>
Subject: Re: [RESEND PATCH v4] clk: stm32f4: fix post divisor setup for I2S/SAI PLLs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Gabriel Fernandez <gabriel.fernandez@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
To:     Dario Binacchi <dariobin@libero.it>,
        Dillon Hua <dillonhua@gmail.com>
Date:   Mon, 02 Aug 2021 15:09:17 -0700
Message-ID: <162794215799.714452.17355927940378699473@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dario Binacchi (2021-08-01 12:37:10)
>=20
> As said in a previous email to Stephen, the patch I submitted fixes commi=
t 517633ef630e
> ("clk: stm32f4: Add post divisor for I2S & SAI PLLs"), so IMHO it should =
not be dropped from the tree.
> What Dillon suggested should instead be fixed by another patch.

Ok. I'll send off the fix to Linus today.
