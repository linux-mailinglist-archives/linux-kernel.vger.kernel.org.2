Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8438A44B16F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 17:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238308AbhKIQs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 11:48:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:59616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235519AbhKIQsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 11:48:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4954E60234;
        Tue,  9 Nov 2021 16:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636476368;
        bh=7mn3/Rzgs0AY9qDCuvn0WhLRmfJQywPw9A8MRDDKzLU=;
        h=From:To:Cc:Subject:Date:From;
        b=j6yw2Ps7uuFlnMGF0owr7OGP80m62VT+w0TM2iomPo2uDkg1kTL0SRyeL3mt2a65F
         bLFfWW/U2YlV0Qn6VM2XkVKdySdSDRuze4fOBhcB0SW5vD77E8XDbSrOMvu5BQ8E2F
         qvCxyqVFxjSMX9fdCYeOF0JjLEThic83ZbtcZQJXkHwWY0JOgdYCIgJa6+jY0SvTnT
         hIIKnmo4IVhGcaMWYeZLIGirS9lvrt59qeAzE03e1gaVrfn/gl3bsHJtigzGR+WtH/
         AZIW5ZRpzGMJ/ru4B1k6b3T1lpaR3iSd2+oGSeq6+OU0whz4NzllZBpMQDlrGtRguW
         Ii+9VL5BhXP2Q==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: [RFC PATCH 0/7] static call updates
Date:   Tue,  9 Nov 2021 17:45:42 +0100
Message-Id: <20211109164549.1724710-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2171; h=from:subject; bh=7mn3/Rzgs0AY9qDCuvn0WhLRmfJQywPw9A8MRDDKzLU=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBhiqWtdRyFdrqkl7Sd3XUJ9SOKDd1pSdhC9TrPDDe5 rN0/E46JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYYqlrQAKCRDDTyI5ktmPJAdPDA CwXhR4xwEapGvcZK4fNMZFehNUvYIv3ZQsaYUL6iMrcu9OD+SFcRwv94D3QGQhWFazkcJ1Pk9PIlxb PTsV/1U0LffZZj2Qk7iXErj6YwB1+99oVGvk5qDoZRg4IasHhTITiQ2lgXWxqyMTCDpBMztL9r+l0H C3l6cSLQc5DNfm+Db+WXJMVH6TTwIcZ4ITjKCmAoG485mzUDUyyk7jevxZPjtJynceOGnpIRJrb4Dq 4fsiermi8hm/nxblWPZ1wZvt1wWo50yNz076qsgI6akY0FFceGBWMhYcXhy+yKCNZFUedC6vugBLNy Uf7IW7TZGIymPe0vfT+aR/89f0T9snG1KZjdRqbtjOOve24nO3x0RKyHQ25hgOeXcqr8k4s4GQKJUU IGHDpuVLwvquqfBH+3UVbveQ/2/wWx4T0ZHRKB/lp+yVNE4XFecWUetjnFrJ5YtRZZNohIsRfVwvbd +Vx8jrsmk7geL4tmsIUzmpLbfiTW2eU23wjujvnkAMsZs=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series addresses a number of asymmetries and inconsistencies in
both the API and the implementation of static calls. The aim is to
ensure that the documented API is fully implemented and works correctly,
regardless of which variety of static calls the arch decides to
implement.

Another goal of this series is to ensure that the caller of the API does
not need to choose a particular kind of macro depending on whether the
static call exports its key and/or whether the static call in question
may implement the NULL flavor.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Kees Cook <keescook@chromium.org>

Ard Biesheuvel (7):
  static_call: get rid of static_call_cond()
  static_call: deal with unexported keys without cluttering up the API
  static_call: use helper to access non-exported key
  static_call: fix broken static_call_query() for non-exported keys
  static_call: use non-function types to refer to the trampolines
  static_call: rename EXPORT_ macros to be more self-explanatory
  static_call: add generic support for non-exported keys

 arch/x86/events/core.c                  |  20 ++--
 arch/x86/include/asm/kvm_host.h         |   4 +-
 arch/x86/include/asm/preempt.h          |   4 +-
 arch/x86/include/asm/static_call.h      |   6 -
 arch/x86/kvm/irq.c                      |   2 +-
 arch/x86/kvm/x86.c                      |  10 +-
 include/asm-generic/vmlinux.lds.h       |   5 +-
 include/linux/kernel.h                  |   2 +-
 include/linux/sched.h                   |   2 +-
 include/linux/static_call.h             | 117 +++++++++-----------
 include/linux/static_call_types.h       |  54 +++++----
 kernel/extable.c                        |   1 +
 kernel/sched/core.c                     |   8 +-
 kernel/static_call.c                    |  29 +----
 tools/include/linux/static_call_types.h |  54 +++++----
 tools/objtool/check.c                   |  43 ++++---
 16 files changed, 174 insertions(+), 187 deletions(-)

-- 
2.30.2

