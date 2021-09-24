Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D2B416A37
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 04:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243985AbhIXC42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 22:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243961AbhIXC41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 22:56:27 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924ADC061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 19:54:54 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id pf3-20020a17090b1d8300b0019e081aa87bso6522270pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 19:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x/otS4fYYt5orkhqvlVCHrC9APRYcMEwuYCLyqOAbCw=;
        b=HoKz4kn0lo1YB28CvV3caM88rtbuworryJ7Wwashms0+lL2nZ82T2/ceIrlhSlYBqu
         wpwojAMLtjIrEG7PRlSZhMDYj6VTQNTi0XhI3ULNbIts7ZjPiM0rKJ7qCI1kX6KMuHxg
         h4Wy5vWx+fYskgxs32SLz0oU6CHtMBhTUbvZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x/otS4fYYt5orkhqvlVCHrC9APRYcMEwuYCLyqOAbCw=;
        b=2crCs7c21AJY3cslUNxSyuDXaY2pwQLi9YqFBw8RcnMW9u/GBAune0OKgJyaiDH6fG
         gBjleEch1z7t+JiDBizgF/CdyAb8STvOtOxzUKtP4+6lWrdhgkcBzptHFWSSbWyxQicC
         wcXaCN59gmpiNNoeWQSiWvTUXjy8vA5DzwNcRhbJj4gTSpHsiZm4lRSWh9vAph1KzTkN
         ZfF+CRFTH7eQ/b8NB/DqaVlREwLnphPwboQQsxaiDj6Af6+PETvQFgNDZKrsCELj4SD7
         tQdb+hhcjEeSKu9Rl2lC6iPnKaEQfKZ3uZKb8iM+M3iXcQ54G0NHDJb3ExBqIhKP1JVI
         XXjw==
X-Gm-Message-State: AOAM533CB+PtK9H7Mwcv4cazQqGHpYFdzIeYpVorsTGHaEXWYaI14oa3
        JLtvqEr7Ayd8Eu+r0YxkDR5GwQ==
X-Google-Smtp-Source: ABdhPJzoxTaDLYOH4lAboKzPideKEDEHhfDZpboc2kTJqCHQzEnYAvsdL+bUr8YNbm8GcyGoNclHdg==
X-Received: by 2002:a17:902:8547:b0:13d:ebc2:44ba with SMTP id d7-20020a170902854700b0013debc244bamr80191plo.85.1632452094100;
        Thu, 23 Sep 2021 19:54:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c7sm2387452pfc.104.2021.09.23.19.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 19:54:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] sched: task_struct: Fill unconditional hole induced by sched_entity
Date:   Thu, 23 Sep 2021 19:54:50 -0700
Message-Id: <20210924025450.4138503-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2265; h=from:subject; bh=OChNcp6I5i2JyMYJgSU/A4wZJLWThJmzupcLJsTGAvI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhTT35ElpufKwKZiO1u4fwq/4lyJdqiqEVfbPN22Gw Os7ZB4OJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYU09+QAKCRCJcvTf3G3AJoFfD/ 0YKgsBLCDhIRcAcUyIMQzbiPW9EShghCQLHwUSYosw++4VjoNuoS+n09DJHxK0TNsEk2AIcT8BYklY +ssatisxHOIn6mSDVs82iGaJo62UcwNQHyQT+JjHPsnQnNEUrOg7xtqAgiSbFCkKn1A99jrpTACymo zfo2VQtLIJ8dwHV8g1mCNAfegN/iN6DkX3BHai+mKTpUactc4XM2XdD65at6M78xwagCfdviWTW0UQ ibJtFmMPJ9gRwCGz5cFpT3qt/fnqijw9OQQaCM8ibzJq1w8f5M9KJsfNAnVy1SAmnLNz3tH56MlqSe S2r9bryD2ZDH0ZekQlyq6dqxSehiFQPk310/qnUDPiI9X6o2T1VN87JFhXc6zgl63tuXK6hrqMdrCM OcdSWVdIkN5sX8LM9D8ofK+fmjlNG6le4xXkDMJC1QVD2r+0awAHxNNN5ymWfq4tZiwEJBlbQAFuAW 4dh+ihLVKiLsnzJcrmKUG70pf69VBWklolODs2hpSiDCx6DLgxSXPwDUc2HCv9yJo0VG1+LGnvgp9g Y0z+9fHBzuLqWzVncmH4fB076UrSrT+lf8xqVYNtpVVWVeaktjIL0p+c/5KJBac3cDM3mSDvndvNmj bx72B1aIy1HWRS3Kjity5LX2y21vGkEwwak2c1AVCM0dXi0tKLTBks2mN+fw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With struct sched_entity before the other sched entities, its alignment
won't induce a struct hole. This saves 64 bytes in defconfig task_struct:

Before:
	...
        unsigned int               rt_priority;          /*   120     4 */

        /* XXX 4 bytes hole, try to pack */

        /* --- cacheline 2 boundary (128 bytes) --- */
        const struct sched_class  * sched_class;         /*   128     8 */

        /* XXX 56 bytes hole, try to pack */

        /* --- cacheline 3 boundary (192 bytes) --- */
        struct sched_entity        se __attribute__((__aligned__(64))); /*   192   448 */
        /* --- cacheline 10 boundary (640 bytes) --- */
        struct sched_rt_entity     rt;                   /*   640    48 */
        struct sched_dl_entity     dl __attribute__((__aligned__(8))); /*   688   224 */
        /* --- cacheline 14 boundary (896 bytes) was 16 bytes ago --- */

After:
	...
        unsigned int               rt_priority;          /*   120     4 */

        /* XXX 4 bytes hole, try to pack */

        /* --- cacheline 2 boundary (128 bytes) --- */
        struct sched_entity        se __attribute__((__aligned__(64))); /*   128   448 */
        /* --- cacheline 9 boundary (576 bytes) --- */
        struct sched_rt_entity     rt;                   /*   576    48 */
        struct sched_dl_entity     dl __attribute__((__aligned__(8))); /*   624   224 */
        /* --- cacheline 13 boundary (832 bytes) was 16 bytes ago --- */

Summary diff:
-	/* size: 7040, cachelines: 110, members: 188 */
+	/* size: 6976, cachelines: 109, members: 188 */

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 39039ce8ac4c..27ed1d40028f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -775,10 +775,10 @@ struct task_struct {
 	int				normal_prio;
 	unsigned int			rt_priority;
 
-	const struct sched_class	*sched_class;
 	struct sched_entity		se;
 	struct sched_rt_entity		rt;
 	struct sched_dl_entity		dl;
+	const struct sched_class	*sched_class;
 
 #ifdef CONFIG_SCHED_CORE
 	struct rb_node			core_node;
-- 
2.30.2

