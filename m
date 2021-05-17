Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59338383969
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241754AbhEQQP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:15:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343659AbhEQPwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 11:52:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81F8361004;
        Mon, 17 May 2021 15:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621266048;
        bh=Z2VtwwaRI/pH2lz/F3sJhJFxo/YXW1gRBpr+2tkqnrg=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=XZ/x02u/Y15eO2oMZFmhgPtm8VdXTwgx3YlaPphg6hQEsf74CkPCejpne6A/46lZq
         106x6hDl6oTeXj2Wt4TqDvoTgOsnGfwAte4Xd1u0J2/ifIHyzabYuUQFK9kvJ4e33j
         rQTV6faIPA3+BTTpOQCbYKPJFv61Hh9c6rXDri2l2VZZw7B1DLS6ealm4+DFZ5vbwi
         uhBb0HFpuT/r9SniDu0ogJO5KK7S0vBQEI7zy7UqEI/pCpU7Yrf1erMOqSWkeihyE/
         HQXkCTxAcT7cKKPeU88R//OmtFa/M1xbkyhalyv+8gduwvtMKhXW3aSH7VXFMwc+tW
         VGA3Xe+RXzwOA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 50E605C00C6; Mon, 17 May 2021 08:40:48 -0700 (PDT)
Date:   Mon, 17 May 2021 08:40:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     liam.howlett@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: RCU tests for Maple Tree
Message-ID: <20210517154048.GA2013926@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Liam!

Apologies for my being so slow here, but just wanted to double-check my
understanding of this code.

There appear to be two tests that execute from run_check_rcu():

o	rcu_loop().  This appears to have RCU readers scanning the tree
	while an updater is adding a single range.  (Or replacing it,
	as the case might be.)

o	rcu_val().  This appears to have RCU readers repeatedly reading a
	given value while an updater is adding/replacing a single range.
	The test complains if no one sees the new value.

These tests appear to be the only use of threads, though perhaps the
test harness has some way of creating threads that I missed.

Are there other tests that I should be looking for?

							Thanx, Paul
