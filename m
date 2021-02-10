Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D8E316190
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhBJI4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:56:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57632 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhBJIxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:53:38 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612947175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wI4dYA0LemOEeK7ck9OsgEy8vt00i1M3Et4kBaT742I=;
        b=FePiSAFmqsrH5sPz7TKOXO67Vc6lP2feeRBjSexAD2DRWCeXDQeBmuaufc7TSuu1mwK4Cl
        M+yXBUWCFHH3C+2WQQwGN2q8FR/LygHDOTgUIN01pmrhmO/RK3PBhG/1qDISf8mYrbjjFm
        nJ5Nrf1DaTrXKZFcdWjQ+AvzlEJS+9XAbsfIkOxjq65EYwmClZJTuGdZ5OT3OG3hB+YlDz
        VOI773N9XrvFO7TWmkIj14mWY0TvZ2aI5vLVSMWORRcl/MRc1nUnGDSt81GU/RoWDv44Om
        aK6+RhlaXPE9LzhQ2ECQwA1pPcgtSN0lcyspFtpL/fcTBIpeNc/cv0RSQzpnPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612947175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wI4dYA0LemOEeK7ck9OsgEy8vt00i1M3Et4kBaT742I=;
        b=h6O5tk3jRSJAGgO0HvlNPXwZSNtVo1mE5BbHlvsrhPW8M85QGkas9VF++KuK6+8smQH5i1
        4tKJp89edeKe6bCg==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/2] locking/mutex: Kill mutex_trylock_recursive()
Date:   Wed, 10 Feb 2021 09:52:46 +0100
Message-Id: <20210210085248.219210-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove mutex_trylock_recursive() from the API and tell checkpatch not to
check it for it anymore.

Sebastian


