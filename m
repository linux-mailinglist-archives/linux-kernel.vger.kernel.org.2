Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07F4364DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 00:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhDSWvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 18:51:33 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:35375 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbhDSWva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 18:51:30 -0400
Received: by mail-io1-f47.google.com with SMTP id h141so28175998iof.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 15:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lGtwy4gezzBoO9ZhoFC/C6pqVb7Mu05Yezx/T7Ux99c=;
        b=cxc2Cf68mtdcTj7mNUtR9162+yyl0fTsg49p27ffGvkNiAU5j/zYUoHXiGRAi6iaVW
         bN1glPk7dzfC6qhHikAooOnSLCvWwMhEB8ZnTki4NAU/E2es++YEF6Ozh/5+Y79o84LK
         EbQp1piJyz/8DFcwERLrYOPm4lZ3S2K4K8So+bp7QUMUCDTAULxjZk93TWuboignlrss
         iIU1HAInULdaZK4+f22a6IvIatzLhA9o2izsxVyVFfl81Z1DZs2DoLSDAnLSBoKsGCYm
         6KfCbCX2nkP5ZlE946NilNvZru8k8fGr+ksCQDoVXbdk3l7JmgT0FbgKvwQ0bdG5CCRd
         FY4w==
X-Gm-Message-State: AOAM533jWgBtXyTEpLI5agpp0PR4DvJjpV8Coi9xbZYe/KkHTsxSwVuM
        KJb5TmYRoUhSwSfkCcSs8jU=
X-Google-Smtp-Source: ABdhPJzVpah/mlRGRhTqneMMEk4zOmZqnaajjyfU5u+TLUhwEMzbasZ2Cl5sAye8L7uMex41uoQHiA==
X-Received: by 2002:a02:a06:: with SMTP id 6mr13915809jaw.112.1618872659936;
        Mon, 19 Apr 2021 15:50:59 -0700 (PDT)
Received: from abasin.c.googlers.com.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id d7sm7566967ion.39.2021.04.19.15.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 15:50:59 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 2/4] percpu: use pcpu_free_slot instead of pcpu_nr_slots - 1
Date:   Mon, 19 Apr 2021 22:50:45 +0000
Message-Id: <20210419225047.3415425-3-dennis@kernel.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210419225047.3415425-1-dennis@kernel.org>
References: <20210419225047.3415425-1-dennis@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prepares for adding a to_depopulate list and sidelined list after
the free slot in the set of lists in pcpu_slot.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 mm/percpu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 5edc7bd88133..d462222f4adc 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -135,6 +135,7 @@ static int pcpu_unit_size __ro_after_init;
 static int pcpu_nr_units __ro_after_init;
 static int pcpu_atom_size __ro_after_init;
 int pcpu_nr_slots __ro_after_init;
+int pcpu_free_slot __ro_after_init;
 static size_t pcpu_chunk_struct_size __ro_after_init;
 
 /* cpus with the lowest and highest unit addresses */
@@ -237,7 +238,7 @@ static int __pcpu_size_to_slot(int size)
 static int pcpu_size_to_slot(int size)
 {
 	if (size == pcpu_unit_size)
-		return pcpu_nr_slots - 1;
+		return pcpu_free_slot;
 	return __pcpu_size_to_slot(size);
 }
 
@@ -1806,7 +1807,7 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 		goto fail;
 	}
 
-	if (list_empty(&pcpu_slot[pcpu_nr_slots - 1])) {
+	if (list_empty(&pcpu_slot[pcpu_free_slot])) {
 		chunk = pcpu_create_chunk(type, pcpu_gfp);
 		if (!chunk) {
 			err = "failed to allocate new chunk";
@@ -1958,7 +1959,7 @@ static void pcpu_balance_free(enum pcpu_chunk_type type)
 {
 	LIST_HEAD(to_free);
 	struct list_head *pcpu_slot = pcpu_chunk_list(type);
-	struct list_head *free_head = &pcpu_slot[pcpu_nr_slots - 1];
+	struct list_head *free_head = &pcpu_slot[pcpu_free_slot];
 	struct pcpu_chunk *chunk, *next;
 
 	/*
@@ -2033,7 +2034,7 @@ static void pcpu_balance_populated(enum pcpu_chunk_type type)
 				  0, PCPU_EMPTY_POP_PAGES_HIGH);
 	}
 
-	for (slot = pcpu_size_to_slot(PAGE_SIZE); slot < pcpu_nr_slots; slot++) {
+	for (slot = pcpu_size_to_slot(PAGE_SIZE); slot <= pcpu_free_slot; slot++) {
 		unsigned int nr_unpop = 0, rs, re;
 
 		if (!nr_to_pop)
@@ -2140,7 +2141,7 @@ void free_percpu(void __percpu *ptr)
 	if (chunk->free_bytes == pcpu_unit_size) {
 		struct pcpu_chunk *pos;
 
-		list_for_each_entry(pos, &pcpu_slot[pcpu_nr_slots - 1], list)
+		list_for_each_entry(pos, &pcpu_slot[pcpu_free_slot], list)
 			if (pos != chunk) {
 				need_balance = true;
 				break;
@@ -2562,7 +2563,8 @@ void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
 	 * Allocate chunk slots.  The additional last slot is for
 	 * empty chunks.
 	 */
-	pcpu_nr_slots = __pcpu_size_to_slot(pcpu_unit_size) + 2;
+	pcpu_free_slot = __pcpu_size_to_slot(pcpu_unit_size) + 1;
+	pcpu_nr_slots = pcpu_free_slot + 1;
 	pcpu_chunk_lists = memblock_alloc(pcpu_nr_slots *
 					  sizeof(pcpu_chunk_lists[0]) *
 					  PCPU_NR_CHUNK_TYPES,
-- 
2.31.1.368.gbe11c130af-goog

