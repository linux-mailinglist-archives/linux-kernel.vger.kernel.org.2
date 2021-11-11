Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A71744CE65
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 01:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbhKKAjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 19:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhKKAjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 19:39:17 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C84C061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 16:36:29 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id p18so4322394plf.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 16:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y39O7L0VYZ0AOnDZ/VQ4mYlUhIpt4KibZ8jsie/NVYU=;
        b=QWY1aSdDEjyl5zHnr1KyCXRUo66gPdwG3/+Y5b7UssGbOthAtgpVZyfy4itCMdRa9y
         SV26Gt9JpsOMRreysHyd1Um92SSQomHd2cEdBG1tGaPliw+hP6CsBYsPjR75jjfONvtG
         ilRN5Z8GphnemuU7k44b+HCfzoWplrn62lPJmDJBdjDUAFJPGyxZUeZoCZ5qmuYxHE4K
         2c8xFSc5DSSF2lSDVKE2SWoNtULD6WjAw4XrwlaPaJHEsfNC36xFt9Ksq5jkpULEdmBf
         lYOMLFCUXvfpPFsnLvipxV7mFp8wvBajs+K4Urn4JVuH+itzFgIIiER4IJN1HPDBqZZ4
         KFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y39O7L0VYZ0AOnDZ/VQ4mYlUhIpt4KibZ8jsie/NVYU=;
        b=y3Zoil/fH8O/y78ujFrrC/FW5i7RE/RV3jppa/bRIaCGmqWaznKEElvjvjitpCpj2T
         b91BAleYDT8Tkt0y/cCSdTftiPacemFWODdbTZIYEWWrDqNK9tkx1o9yFSCTk40bPqrd
         4U1YiT4tlQDsz24/kX2nOfj+Dv/OvV458HbE7K3C12dCjYRctCm6h9Dlz+xt80JBlo8g
         mVeV0kGPW2DyiVWtVOZGZDNNVdnVpaCyHIjcNYZyTmxht2eX5tpYs86GvSOAjvTYMtl+
         3VpZGVw16nWdmYH2Vnw4OFi4dHu6uEgrYDLos41azDE4smvRcS/zDfYB80IEAxzRAX8v
         uAaw==
X-Gm-Message-State: AOAM5314VhUNQGJBKH1yJF0CQYB3i12dHJmgZyzctd88PZZykC3YKA+F
        93YJl148CZDYp2NUJKWh3dprKVM1d/uXORrp
X-Google-Smtp-Source: ABdhPJzsEJPjex1NQG/DhTFSkbnjJK5xOirxbEJzhreVw6bHOiXhCLAfnqx4eAPR6nsttvIURobvHQ==
X-Received: by 2002:a17:90a:a396:: with SMTP id x22mr3733568pjp.14.1636590988824;
        Wed, 10 Nov 2021 16:36:28 -0800 (PST)
Received: from localhost.localdomain ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id h6sm843379pfh.82.2021.11.10.16.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 16:36:28 -0800 (PST)
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Tadeusz Struk <tadeusz.struk@linaro.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Jonathan Lemon" <jonathan.lemon@gmail.com>,
        "Alexander Lobakin" <alobakin@pm.me>,
        "Willem de Bruijn" <willemb@google.com>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "Cong Wang" <cong.wang@bytedance.com>,
        "Kevin Hao" <haokexin@gmail.com>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        "Marco Elver" <elver@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] skbuff: suppress clang object-size-mismatch error
Date:   Wed, 10 Nov 2021 16:35:19 -0800
Message-Id: <20211111003519.1050494-1-tadeusz.struk@linaro.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel throws a runtime object-size-mismatch error in skbuff queue
helpers like in [1]. This happens every time there is a pattern
like the below:

int skbuf_xmit(struct sk_buff *skb)
{
        struct sk_buff_head list;

        __skb_queue_head_init(&list);
        __skb_queue_tail(&list, skb); <-- offending call

        return do_xmit(net, &list);
}

and the kernel is build with clang and -fsanitize=undefined flag set.
The reason is that the functions __skb_queue_[tail|head]() access the
struct sk_buff_head object via a pointer to struct sk_buff, which is
much bigger in size than the sk_buff_head. This could cause undefined
behavior and clang is complaining:

UBSAN: object-size-mismatch in ./include/linux/skbuff.h:2023:28
member access within address ffffc90000cb71c0 with insufficient space
for an object of type 'struct sk_buff'

Suppress the error with __attribute__((no_sanitize("undefined")))
in the skb helpers.

[1] https://syzkaller.appspot.com/bug?id=5d9f0bca58cea80f272b73500df67dcd9e35c886

Cc: "Nathan Chancellor" <nathan@kernel.org>
Cc: "Nick Desaulniers" <ndesaulniers@google.com>
Cc: "Jakub Kicinski" <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: "Jonathan Lemon" <jonathan.lemon@gmail.com>
Cc: "Alexander Lobakin" <alobakin@pm.me>
Cc: "Willem de Bruijn" <willemb@google.com>
Cc: "Paolo Abeni" <pabeni@redhat.com>
Cc: "Cong Wang" <cong.wang@bytedance.com>
Cc: "Kevin Hao" <haokexin@gmail.com>
Cc: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Cc: "Marco Elver" <elver@google.com>
Cc: <netdev@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: <llvm@lists.linux.dev>

Signed-off-by: Tadeusz Struk <tadeusz.struk@linaro.org>
---
 include/linux/skbuff.h | 49 ++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 0bd6520329f6..8ec46e3a503d 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1933,9 +1933,10 @@ static inline void skb_queue_head_init_class(struct sk_buff_head *list,
  *	The "__skb_xxxx()" functions are the non-atomic ones that
  *	can only be called with interrupts disabled.
  */
-static inline void __skb_insert(struct sk_buff *newsk,
-				struct sk_buff *prev, struct sk_buff *next,
-				struct sk_buff_head *list)
+static inline void __no_sanitize_undefined
+__skb_insert(struct sk_buff *newsk,
+	     struct sk_buff *prev, struct sk_buff *next,
+	     struct sk_buff_head *list)
 {
 	/* See skb_queue_empty_lockless() and skb_peek_tail()
 	 * for the opposite READ_ONCE()
@@ -1966,8 +1967,9 @@ static inline void __skb_queue_splice(const struct sk_buff_head *list,
  *	@list: the new list to add
  *	@head: the place to add it in the first list
  */
-static inline void skb_queue_splice(const struct sk_buff_head *list,
-				    struct sk_buff_head *head)
+static inline void __no_sanitize_undefined
+skb_queue_splice(const struct sk_buff_head *list,
+		 struct sk_buff_head *head)
 {
 	if (!skb_queue_empty(list)) {
 		__skb_queue_splice(list, (struct sk_buff *) head, head->next);
@@ -1982,8 +1984,9 @@ static inline void skb_queue_splice(const struct sk_buff_head *list,
  *
  *	The list at @list is reinitialised
  */
-static inline void skb_queue_splice_init(struct sk_buff_head *list,
-					 struct sk_buff_head *head)
+static inline void __no_sanitize_undefined
+skb_queue_splice_init(struct sk_buff_head *list,
+		      struct sk_buff_head *head)
 {
 	if (!skb_queue_empty(list)) {
 		__skb_queue_splice(list, (struct sk_buff *) head, head->next);
@@ -1997,8 +2000,9 @@ static inline void skb_queue_splice_init(struct sk_buff_head *list,
  *	@list: the new list to add
  *	@head: the place to add it in the first list
  */
-static inline void skb_queue_splice_tail(const struct sk_buff_head *list,
-					 struct sk_buff_head *head)
+static inline void __no_sanitize_undefined
+skb_queue_splice_tail(const struct sk_buff_head *list,
+		      struct sk_buff_head *head)
 {
 	if (!skb_queue_empty(list)) {
 		__skb_queue_splice(list, head->prev, (struct sk_buff *) head);
@@ -2014,8 +2018,9 @@ static inline void skb_queue_splice_tail(const struct sk_buff_head *list,
  *	Each of the lists is a queue.
  *	The list at @list is reinitialised
  */
-static inline void skb_queue_splice_tail_init(struct sk_buff_head *list,
-					      struct sk_buff_head *head)
+static inline void __no_sanitize_undefined
+skb_queue_splice_tail_init(struct sk_buff_head *list,
+			   struct sk_buff_head *head)
 {
 	if (!skb_queue_empty(list)) {
 		__skb_queue_splice(list, head->prev, (struct sk_buff *) head);
@@ -2035,9 +2040,10 @@ static inline void skb_queue_splice_tail_init(struct sk_buff_head *list,
  *
  *	A buffer cannot be placed on two lists at the same time.
  */
-static inline void __skb_queue_after(struct sk_buff_head *list,
-				     struct sk_buff *prev,
-				     struct sk_buff *newsk)
+static inline void __no_sanitize_undefined
+__skb_queue_after(struct sk_buff_head *list,
+		  struct sk_buff *prev,
+		  struct sk_buff *newsk)
 {
 	__skb_insert(newsk, prev, prev->next, list);
 }
@@ -2045,9 +2051,10 @@ static inline void __skb_queue_after(struct sk_buff_head *list,
 void skb_append(struct sk_buff *old, struct sk_buff *newsk,
 		struct sk_buff_head *list);
 
-static inline void __skb_queue_before(struct sk_buff_head *list,
-				      struct sk_buff *next,
-				      struct sk_buff *newsk)
+static inline void __no_sanitize_undefined
+__skb_queue_before(struct sk_buff_head *list,
+		   struct sk_buff *next,
+		   struct sk_buff *newsk)
 {
 	__skb_insert(newsk, next->prev, next, list);
 }
@@ -2062,8 +2069,8 @@ static inline void __skb_queue_before(struct sk_buff_head *list,
  *
  *	A buffer cannot be placed on two lists at the same time.
  */
-static inline void __skb_queue_head(struct sk_buff_head *list,
-				    struct sk_buff *newsk)
+static inline void __no_sanitize_undefined
+__skb_queue_head(struct sk_buff_head *list, struct sk_buff *newsk)
 {
 	__skb_queue_after(list, (struct sk_buff *)list, newsk);
 }
@@ -2079,8 +2086,8 @@ void skb_queue_head(struct sk_buff_head *list, struct sk_buff *newsk);
  *
  *	A buffer cannot be placed on two lists at the same time.
  */
-static inline void __skb_queue_tail(struct sk_buff_head *list,
-				   struct sk_buff *newsk)
+static inline void __no_sanitize_undefined
+__skb_queue_tail(struct sk_buff_head *list, struct sk_buff *newsk)
 {
 	__skb_queue_before(list, (struct sk_buff *)list, newsk);
 }
-- 
2.33.1

