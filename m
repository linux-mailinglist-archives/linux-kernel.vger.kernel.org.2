Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D2935B794
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 02:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbhDLAG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 20:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhDLAGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 20:06:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A531C061574;
        Sun, 11 Apr 2021 17:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=12t++Li3VLoa7S6Q/3be+afleHNcLZ2Y15EbDSGre2c=; b=TzvrxcG46U8BVjRhLQlyBVmE3Z
        9kSFahN2k+1DmKhEFepQa/DfzPBuC1LhDGQnaznwQJ9Vsja0CmWFAaTAJxsYPk2au5Arcz2DoQPYb
        wp3gJqew9Mp4bV+KE8lOW4a5fyePvvh2eleHshrtGtsXZuN0P8GM9s3WBl3tDWWG0IWYfzyQwGnAm
        BZpDOyct3HElxMZFNmdIT9vxsa01+RjuTRC5+f8WJOOipVQEVzPrFxHYhguj33p5mdwyPIlDNYprM
        FTefZy5nz9Vyv3PAYBqeGYBvzpVRAjeqFc744sGyt2/sLLdx7KqzvAMpN9nKQfClLpU4kpomURmNq
        41NonYVQ==;
Received: from [2601:1c0:6280:3f0::e0e1] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVk5Y-003cLb-1X; Mon, 12 Apr 2021 00:06:15 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [PATCH] crypto: fix kernel-doc notation in chacha.c and af_alg.c
Date:   Sun, 11 Apr 2021 17:05:56 -0700
Message-Id: <20210412000556.32051-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix function name in chacha.c kernel-doc comment to remove a warning.

Convert af_alg.c to kernel-doc notation to eliminate many kernel-doc
warnings.

../lib/crypto/chacha.c:77: warning: expecting prototype for chacha_block(). Prototype was for chacha_block_generic() instead
chacha.c:104: warning: Excess function parameter 'out' description in 'hchacha_block_generic'

af_alg.c:498: warning: Function parameter or member 'sk' not described in 'af_alg_alloc_tsgl'
../crypto/af_alg.c:539: warning: expecting prototype for aead_count_tsgl(). Prototype was for af_alg_count_tsgl() instead
../crypto/af_alg.c:596: warning: expecting prototype for aead_pull_tsgl(). Prototype was for af_alg_pull_tsgl() instead
af_alg.c:663: warning: Function parameter or member 'areq' not described in 'af_alg_free_areq_sgls'
af_alg.c:700: warning: Function parameter or member 'sk' not described in 'af_alg_wait_for_wmem'
af_alg.c:700: warning: Function parameter or member 'flags' not described in 'af_alg_wait_for_wmem'
af_alg.c:731: warning: Function parameter or member 'sk' not described in 'af_alg_wmem_wakeup'
af_alg.c:757: warning: Function parameter or member 'sk' not described in 'af_alg_wait_for_data'
af_alg.c:757: warning: Function parameter or member 'flags' not described in 'af_alg_wait_for_data'
af_alg.c:757: warning: Function parameter or member 'min' not described in 'af_alg_wait_for_data'
af_alg.c:796: warning: Function parameter or member 'sk' not described in 'af_alg_data_wakeup'
af_alg.c:832: warning: Function parameter or member 'sock' not described in 'af_alg_sendmsg'
af_alg.c:832: warning: Function parameter or member 'msg' not described in 'af_alg_sendmsg'
af_alg.c:832: warning: Function parameter or member 'size' not described in 'af_alg_sendmsg'
af_alg.c:832: warning: Function parameter or member 'ivsize' not described in 'af_alg_sendmsg'
af_alg.c:985: warning: Function parameter or member 'sock' not described in 'af_alg_sendpage'
af_alg.c:985: warning: Function parameter or member 'page' not described in 'af_alg_sendpage'
af_alg.c:985: warning: Function parameter or member 'offset' not described in 'af_alg_sendpage'
af_alg.c:985: warning: Function parameter or member 'size' not described in 'af_alg_sendpage'
af_alg.c:985: warning: Function parameter or member 'flags' not described in 'af_alg_sendpage'
af_alg.c:1040: warning: Function parameter or member 'areq' not described in 'af_alg_free_resources'
af_alg.c:1059: warning: Function parameter or member '_req' not described in 'af_alg_async_cb'
af_alg.c:1059: warning: Function parameter or member 'err' not described in 'af_alg_async_cb'
af_alg.c:1083: warning: Function parameter or member 'file' not described in 'af_alg_poll'
af_alg.c:1083: warning: Function parameter or member 'sock' not described in 'af_alg_poll'
af_alg.c:1083: warning: Function parameter or member 'wait' not described in 'af_alg_poll'
af_alg.c:1114: warning: Function parameter or member 'sk' not described in 'af_alg_alloc_areq'
af_alg.c:1114: warning: Function parameter or member 'areqlen' not described in 'af_alg_alloc_areq'
af_alg.c:1146: warning: Function parameter or member 'sk' not described in 'af_alg_get_rsgl'
af_alg.c:1146: warning: Function parameter or member 'msg' not described in 'af_alg_get_rsgl'
af_alg.c:1146: warning: Function parameter or member 'flags' not described in 'af_alg_get_rsgl'
af_alg.c:1146: warning: Function parameter or member 'areq' not described in 'af_alg_get_rsgl'
af_alg.c:1146: warning: Function parameter or member 'maxsize' not described in 'af_alg_get_rsgl'
af_alg.c:1146: warning: Function parameter or member 'outlen' not described in 'af_alg_get_rsgl'


Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
---
 crypto/af_alg.c     |   94 +++++++++++++++++++++++-------------------
 lib/crypto/chacha.c |    4 -
 2 files changed, 55 insertions(+), 43 deletions(-)

--- linux-next-20210409.orig/lib/crypto/chacha.c
+++ linux-next-20210409/lib/crypto/chacha.c
@@ -64,7 +64,7 @@ static void chacha_permute(u32 *x, int n
 }
 
 /**
- * chacha_block - generate one keystream block and increment block counter
+ * chacha_block_generic - generate one keystream block and increment block counter
  * @state: input state matrix (16 32-bit words)
  * @stream: output keystream block (64 bytes)
  * @nrounds: number of rounds (20 or 12; 20 is recommended)
@@ -92,7 +92,7 @@ EXPORT_SYMBOL(chacha_block_generic);
 /**
  * hchacha_block_generic - abbreviated ChaCha core, for XChaCha
  * @state: input state matrix (16 32-bit words)
- * @out: output (8 32-bit words)
+ * @stream: output (8 32-bit words)
  * @nrounds: number of rounds (20 or 12; 20 is recommended)
  *
  * HChaCha is the ChaCha equivalent of HSalsa and is an intermediate step
--- linux-next-20210409.orig/crypto/af_alg.c
+++ linux-next-20210409/crypto/af_alg.c
@@ -491,8 +491,8 @@ static int af_alg_cmsg_send(struct msghd
 /**
  * af_alg_alloc_tsgl - allocate the TX SGL
  *
- * @sk socket of connection to user space
- * @return: 0 upon success, < 0 upon error
+ * @sk: socket of connection to user space
+ * Return: 0 upon success, < 0 upon error
  */
 static int af_alg_alloc_tsgl(struct sock *sk)
 {
@@ -525,15 +525,15 @@ static int af_alg_alloc_tsgl(struct sock
 }
 
 /**
- * aead_count_tsgl - Count number of TX SG entries
+ * af_alg_count_tsgl - Count number of TX SG entries
  *
  * The counting starts from the beginning of the SGL to @bytes. If
- * an offset is provided, the counting of the SG entries starts at the offset.
+ * an @offset is provided, the counting of the SG entries starts at the @offset.
  *
- * @sk socket of connection to user space
- * @bytes Count the number of SG entries holding given number of bytes.
- * @offset Start the counting of SG entries from the given offset.
- * @return Number of TX SG entries found given the constraints
+ * @sk: socket of connection to user space
+ * @bytes: Count the number of SG entries holding given number of bytes.
+ * @offset: Start the counting of SG entries from the given offset.
+ * Return: Number of TX SG entries found given the constraints
  */
 unsigned int af_alg_count_tsgl(struct sock *sk, size_t bytes, size_t offset)
 {
@@ -577,19 +577,19 @@ unsigned int af_alg_count_tsgl(struct so
 EXPORT_SYMBOL_GPL(af_alg_count_tsgl);
 
 /**
- * aead_pull_tsgl - Release the specified buffers from TX SGL
+ * af_alg_pull_tsgl - Release the specified buffers from TX SGL
  *
- * If @dst is non-null, reassign the pages to dst. The caller must release
+ * If @dst is non-null, reassign the pages to @dst. The caller must release
  * the pages. If @dst_offset is given only reassign the pages to @dst starting
  * at the @dst_offset (byte). The caller must ensure that @dst is large
  * enough (e.g. by using af_alg_count_tsgl with the same offset).
  *
- * @sk socket of connection to user space
- * @used Number of bytes to pull from TX SGL
- * @dst If non-NULL, buffer is reassigned to dst SGL instead of releasing. The
- *	caller must release the buffers in dst.
- * @dst_offset Reassign the TX SGL from given offset. All buffers before
- *	       reaching the offset is released.
+ * @sk: socket of connection to user space
+ * @used: Number of bytes to pull from TX SGL
+ * @dst: If non-NULL, buffer is reassigned to dst SGL instead of releasing. The
+ *	 caller must release the buffers in dst.
+ * @dst_offset: Reassign the TX SGL from given offset. All buffers before
+ *	        reaching the offset is released.
  */
 void af_alg_pull_tsgl(struct sock *sk, size_t used, struct scatterlist *dst,
 		      size_t dst_offset)
@@ -657,7 +657,7 @@ EXPORT_SYMBOL_GPL(af_alg_pull_tsgl);
 /**
  * af_alg_free_areq_sgls - Release TX and RX SGLs of the request
  *
- * @areq Request holding the TX and RX SGL
+ * @areq: Request holding the TX and RX SGL
  */
 static void af_alg_free_areq_sgls(struct af_alg_async_req *areq)
 {
@@ -692,9 +692,9 @@ static void af_alg_free_areq_sgls(struct
 /**
  * af_alg_wait_for_wmem - wait for availability of writable memory
  *
- * @sk socket of connection to user space
- * @flags If MSG_DONTWAIT is set, then only report if function would sleep
- * @return 0 when writable memory is available, < 0 upon error
+ * @sk: socket of connection to user space
+ * @flags: If MSG_DONTWAIT is set, then only report if function would sleep
+ * Return: 0 when writable memory is available, < 0 upon error
  */
 static int af_alg_wait_for_wmem(struct sock *sk, unsigned int flags)
 {
@@ -725,7 +725,7 @@ static int af_alg_wait_for_wmem(struct s
 /**
  * af_alg_wmem_wakeup - wakeup caller when writable memory is available
  *
- * @sk socket of connection to user space
+ * @sk: socket of connection to user space
  */
 void af_alg_wmem_wakeup(struct sock *sk)
 {
@@ -748,10 +748,10 @@ EXPORT_SYMBOL_GPL(af_alg_wmem_wakeup);
 /**
  * af_alg_wait_for_data - wait for availability of TX data
  *
- * @sk socket of connection to user space
- * @flags If MSG_DONTWAIT is set, then only report if function would sleep
- * @min Set to minimum request size if partial requests are allowed.
- * @return 0 when writable memory is available, < 0 upon error
+ * @sk: socket of connection to user space
+ * @flags: If MSG_DONTWAIT is set, then only report if function would sleep
+ * @min: Set to minimum request size if partial requests are allowed.
+ * Return: 0 when writable memory is available, < 0 upon error
  */
 int af_alg_wait_for_data(struct sock *sk, unsigned flags, unsigned min)
 {
@@ -790,7 +790,7 @@ EXPORT_SYMBOL_GPL(af_alg_wait_for_data);
 /**
  * af_alg_data_wakeup - wakeup caller when new data can be sent to kernel
  *
- * @sk socket of connection to user space
+ * @sk: socket of connection to user space
  */
 static void af_alg_data_wakeup(struct sock *sk)
 {
@@ -820,12 +820,12 @@ static void af_alg_data_wakeup(struct so
  *
  * In addition, the ctx is filled with the information sent via CMSG.
  *
- * @sock socket of connection to user space
- * @msg message from user space
- * @size size of message from user space
- * @ivsize the size of the IV for the cipher operation to verify that the
+ * @sock: socket of connection to user space
+ * @msg: message from user space
+ * @size: size of message from user space
+ * @ivsize: the size of the IV for the cipher operation to verify that the
  *	   user-space-provided IV has the right size
- * @return the number of copied data upon success, < 0 upon error
+ * Return: the number of copied data upon success, < 0 upon error
  */
 int af_alg_sendmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		   unsigned int ivsize)
@@ -977,6 +977,11 @@ EXPORT_SYMBOL_GPL(af_alg_sendmsg);
 
 /**
  * af_alg_sendpage - sendpage system call handler
+ * @sock: socket of connection to user space to write to
+ * @page: data to send
+ * @offset: offset into page to begin sending
+ * @size: length of data
+ * @flags: message send/receive flags
  *
  * This is a generic implementation of sendpage to fill ctx->tsgl_list.
  */
@@ -1035,6 +1040,7 @@ EXPORT_SYMBOL_GPL(af_alg_sendpage);
 
 /**
  * af_alg_free_resources - release resources required for crypto request
+ * @areq: Request holding the TX and RX SGL
  */
 void af_alg_free_resources(struct af_alg_async_req *areq)
 {
@@ -1047,6 +1053,9 @@ EXPORT_SYMBOL_GPL(af_alg_free_resources)
 
 /**
  * af_alg_async_cb - AIO callback handler
+ * @_req: async request info
+ * @err: if non-zero, error result to be returned via ki_complete();
+ *       otherwise return the AIO output length via ki_complete().
  *
  * This handler cleans up the struct af_alg_async_req upon completion of the
  * AIO operation.
@@ -1073,6 +1082,9 @@ EXPORT_SYMBOL_GPL(af_alg_async_cb);
 
 /**
  * af_alg_poll - poll system call handler
+ * @file: file pointer
+ * @sock: socket to poll
+ * @wait: poll_table
  */
 __poll_t af_alg_poll(struct file *file, struct socket *sock,
 			 poll_table *wait)
@@ -1098,9 +1110,9 @@ EXPORT_SYMBOL_GPL(af_alg_poll);
 /**
  * af_alg_alloc_areq - allocate struct af_alg_async_req
  *
- * @sk socket of connection to user space
- * @areqlen size of struct af_alg_async_req + crypto_*_reqsize
- * @return allocated data structure or ERR_PTR upon error
+ * @sk: socket of connection to user space
+ * @areqlen: size of struct af_alg_async_req + crypto_*_reqsize
+ * Return: allocated data structure or ERR_PTR upon error
  */
 struct af_alg_async_req *af_alg_alloc_areq(struct sock *sk,
 					   unsigned int areqlen)
@@ -1125,13 +1137,13 @@ EXPORT_SYMBOL_GPL(af_alg_alloc_areq);
  * af_alg_get_rsgl - create the RX SGL for the output data from the crypto
  *		     operation
  *
- * @sk socket of connection to user space
- * @msg user space message
- * @flags flags used to invoke recvmsg with
- * @areq instance of the cryptographic request that will hold the RX SGL
- * @maxsize maximum number of bytes to be pulled from user space
- * @outlen number of bytes in the RX SGL
- * @return 0 on success, < 0 upon error
+ * @sk: socket of connection to user space
+ * @msg: user space message
+ * @flags: flags used to invoke recvmsg with
+ * @areq: instance of the cryptographic request that will hold the RX SGL
+ * @maxsize: maximum number of bytes to be pulled from user space
+ * @outlen: number of bytes in the RX SGL
+ * Return: 0 on success, < 0 upon error
  */
 int af_alg_get_rsgl(struct sock *sk, struct msghdr *msg, int flags,
 		    struct af_alg_async_req *areq, size_t maxsize,
