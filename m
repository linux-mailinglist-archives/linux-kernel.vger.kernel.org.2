Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5909C3A0994
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 03:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhFIBqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 21:46:21 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:34137 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbhFIBqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 21:46:17 -0400
Received: (Authenticated sender: n@nfraprado.net)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 57DC860007;
        Wed,  9 Jun 2021 01:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nfraprado.net;
        s=gm1; t=1623203062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FiczIQOpLwUkbUH4OiKCMBybtZT9qTlWGQ6371aC+A4=;
        b=YaZiTWybPWTmo7xHq8KmjDuYbJ7htro180KQbZrNabAI7jrlO/7R6cYzUmkrhwwZRh8LAc
        79ZwAFyOenkNPQm5hxW0r5FfzPw1WawPVjaERocsau5X/39INNSjqkaWh1BptxCwpVXIeZ
        8xHHV90dW2hE8iWToBfLGXwoStK3RL2nsA7qNx6rplpSFRawIpMam3y7QR0o20Cb5VmuFV
        7tzJLkOPW5AdXzy1j7tbKNQEtjeznHmy+r2Hghc4zoeqQv3Ym0cBs8L94rs+wuwVQ/yJ9s
        hHUi01JPicE0OMPTCm3mcwagkvkByOmO7aP8EOV6FFr2Krobo1zG4NJattwx6A==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <n@nfraprado.net>
To:     linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
        ~lkcamp/patches@lists.sr.ht
Subject: [RFC PATCH 2/2] XArray: Remove literal markup from known constants
Date:   Tue,  8 Jun 2021 22:43:08 -0300
Message-Id: <20210609014308.234027-3-n@nfraprado.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210609014308.234027-1-n@nfraprado.net>
References: <20210609014308.234027-1-n@nfraprado.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove literal markup from known constants, instead relying on
automarkup.py to make them into literals.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Nícolas F. R. A. Prado <n@nfraprado.net>
---
 Documentation/core-api/xarray.rst | 48 +++++++++++++++----------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
index a137a0e6d068..6e608e2e8e5b 100644
--- a/Documentation/core-api/xarray.rst
+++ b/Documentation/core-api/xarray.rst
@@ -22,7 +22,7 @@ The XArray implementation is efficient when the indices used are densely
 clustered; hashing the object and using the hash as the index will not
 perform well.  The XArray is optimised for small indices, but still has
 good performance with large indices.  If your index can be larger than
-``ULONG_MAX`` then the XArray is not the data type for you.  The most
+ULONG_MAX then the XArray is not the data type for you.  The most
 important user of the XArray is the page cache.
 
 Normal pointers may be stored in the XArray directly.  They must be 4-byte
@@ -31,7 +31,7 @@ alloc_page().  It isn't true for arbitrary user-space pointers,
 nor for function pointers.  You can store pointers to statically allocated
 objects, as long as those objects have an alignment of at least 4.
 
-You can also store integers between 0 and ``LONG_MAX`` in the XArray.
+You can also store integers between 0 and LONG_MAX in the XArray.
 You must first convert it into an entry using xa_mk_value().
 When you retrieve an entry from the XArray, you can check whether it is
 a value entry by calling xa_is_value(), and convert it back to
@@ -52,7 +52,7 @@ An unusual feature of the XArray is the ability to create entries which
 occupy a range of indices.  Once stored to, looking up any index in
 the range will return the same entry as looking up any other index in
 the range.  Storing to any index will store to all of them.  Multi-index
-entries can be explicitly split into smaller entries, or storing ``NULL``
+entries can be explicitly split into smaller entries, or storing NULL
 into any entry will cause the XArray to forget about the range.
 
 Normal API
@@ -60,16 +60,16 @@ Normal API
 
 Start by initialising an XArray, either with DEFINE_XARRAY()
 for statically allocated XArrays or xa_init() for dynamically
-allocated ones.  A freshly-initialised XArray contains a ``NULL``
+allocated ones.  A freshly-initialised XArray contains a NULL
 pointer at every index.
 
 You can then set entries using xa_store() and get entries
 using xa_load().  xa_store will overwrite any entry with the
 new entry and return the previous entry stored at that index.  You can
 use xa_erase() instead of calling xa_store() with a
-``NULL`` entry.  There is no difference between an entry that has never
+NULL a entry.  There is no difference between an entry that has never
 been stored to, one that has been erased and one that has most recently
-had ``NULL`` stored to it.
+had NULL stored to it.
 
 You can conditionally replace an entry at an index by using
 xa_cmpxchg().  Like cmpxchg(), it will only succeed if
@@ -78,8 +78,8 @@ which was at that index; if it returns the same entry which was passed as
 'old', then xa_cmpxchg() succeeded.
 
 If you want to only store a new entry to an index if the current entry
-at that index is ``NULL``, you can use xa_insert() which
-returns ``-EBUSY`` if the entry is not empty.
+at that index is NULL, you can use xa_insert() which
+returns -EBUSY if the entry is not empty.
 
 You can copy entries out of the XArray into a plain array by calling
 xa_extract().  Or you can iterate over the present entries in the XArray
@@ -97,14 +97,14 @@ some, but not all of the other indices changing.
 Sometimes you need to ensure that a subsequent call to xa_store()
 will not need to allocate memory.  The xa_reserve() function
 will store a reserved entry at the indicated index.  Users of the
-normal API will see this entry as containing ``NULL``.  If you do
+normal API will see this entry as containing NULL.  If you do
 not need to use the reserved entry, you can call xa_release()
 to remove the unused entry.  If another user has stored to the entry
 in the meantime, xa_release() will do nothing; if instead you
-want the entry to become ``NULL``, you should use xa_erase().
+want the entry to become NULL, you should use xa_erase().
 Using xa_insert() on a reserved entry will fail.
 
-If all entries in the array are ``NULL``, the xa_empty() function
+If all entries in the array are NULL, the xa_empty() function
 will return ``true``.
 
 Finally, you can remove all entries from an XArray by calling
@@ -120,7 +120,7 @@ Each mark may be set or cleared independently of the others.  You can
 iterate over marked entries by using the xa_for_each_marked() iterator.
 
 You can enquire whether a mark is set on an entry by using
-xa_get_mark().  If the entry is not ``NULL``, you can set a mark on it
+xa_get_mark().  If the entry is not NULL, you can set a mark on it
 by using xa_set_mark() and remove the mark from an entry by calling
 xa_clear_mark().  You can ask whether any entry in the XArray has a
 particular mark set by calling xa_marked().  Erasing an entry from the
@@ -151,9 +151,9 @@ interrupts while allocating the ID.
 
 Using xa_store(), xa_cmpxchg() or xa_insert() will
 also mark the entry as being allocated.  Unlike a normal XArray, storing
-``NULL`` will mark the entry as being in use, like xa_reserve().
+NULL will mark the entry as being in use, like xa_reserve().
 To free an entry, use xa_erase() (or xa_release() if
-you only want to free the entry if it's ``NULL``).
+you only want to free the entry if it's NULL).
 
 By default, the lowest free entry is allocated starting from 0.  If you
 want to allocate entries starting at 1, it is more efficient to use
@@ -326,11 +326,11 @@ xas_error() to retrieve the error.  All operations check whether
 the xa_state is in an error state before proceeding, so there's no need
 for you to check for an error after each call; you can make multiple
 calls in succession and only check at a convenient point.  The only
-errors currently generated by the XArray code itself are ``ENOMEM`` and
-``EINVAL``, but it supports arbitrary errors in case you want to call
+errors currently generated by the XArray code itself are ENOMEM and
+EINVAL, but it supports arbitrary errors in case you want to call
 xas_set_err() yourself.
 
-If the xa_state is holding an ``ENOMEM`` error, calling xas_nomem()
+If the xa_state is holding an ENOMEM error, calling xas_nomem()
 will attempt to allocate more memory using the specified gfp flags and
 cache it in the xa_state for the next attempt.  The idea is that you take
 the xa_lock, attempt the operation and drop the lock.  The operation
@@ -340,7 +340,7 @@ can try harder to allocate more memory.  It will return ``true`` if it
 is worth retrying the operation (i.e. that there was a memory error *and*
 more memory was allocated).  If it has previously allocated memory, and
 that memory wasn't used, and there is no error (or some error that isn't
-``ENOMEM``), then it will free the memory previously allocated.
+ENOMEM), then it will free the memory previously allocated.
 
 Internal Entries
 ----------------
@@ -375,10 +375,10 @@ to xas_retry(), and retry the operation if it returns ``true``.
 
    * - Zero
      - xa_is_zero()
-     - Zero entries appear as ``NULL`` through the Normal API, but occupy
+     - Zero entries appear as NULL through the Normal API, but occupy
        an entry in the XArray which can be used to reserve the index for
        future use.  This is used by allocating XArrays for allocated entries
-       which are ``NULL``.
+       which are NULL.
 
 Other internal entries may be added in the future.  As far as possible, they
 will be handled by xas_retry().
@@ -461,9 +461,9 @@ You can create a multi-index entry by using XA_STATE_ORDER()
 or xas_set_order() followed by a call to xas_store().
 Calling xas_load() with a multi-index xa_state will walk the
 xa_state to the right location in the tree, but the return value is not
-meaningful, potentially being an internal entry or ``NULL`` even when there
+meaningful, potentially being an internal entry or NULL even when there
 is an entry stored within the range.  Calling xas_find_conflict()
-will return the first entry within the range or ``NULL`` if there are no
+will return the first entry within the range or NULL if there are no
 entries in the range.  The xas_for_each_conflict() iterator will
 iterate over every entry which overlaps the specified range.
 
@@ -479,8 +479,8 @@ Using xas_next() or xas_prev() with a multi-index xa_state is not
 supported.  Using either of these functions on a multi-index entry will
 reveal sibling entries; these should be skipped over by the caller.
 
-Storing ``NULL`` into any index of a multi-index entry will set the
-entry at every index to ``NULL`` and dissolve the tie.  A multi-index
+Storing NULL into any index of a multi-index entry will set the
+entry at every index to NULL and dissolve the tie.  A multi-index
 entry can be split into entries occupying smaller ranges by calling
 xas_split_alloc() without the xa_lock held, followed by taking the lock
 and calling xas_split().
-- 
2.32.0

