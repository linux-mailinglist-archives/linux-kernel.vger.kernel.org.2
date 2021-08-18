Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9D63F0604
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 16:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239829AbhHROOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 10:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239071AbhHRONB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:13:01 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D89C0612A5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 07:12:22 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id e7so2361951pgk.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 07:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pathpartnertech.com; s=google;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dK18a6NEnGHo+IzSdMHBasBqOTV0j59qtMHNpA74JI8=;
        b=i6SV2ypX9emYPY1ZVfXqzbKYnhPhvsfKwVYsDa2AWjuAWQiNAH5IonLleu819L/h6c
         se7qM5/2g5c+3ODKZkFTOETPIC9lZsCiVogT0rYTucCAGJtugdPxxqF8/+QThfXFtaC6
         nCfpIpYz1I+hVub8L01Dq/jitJYu2rJrVLSlKi/pi67P7hXh3rQqTYd3YAJBFenlAY2f
         Ws0F8HO0fMQpZIgIVoA4zDjAk8cnTzcMJmNUjLzUQRYZAaoqZIF6njgGMFeppTUDvr6y
         si1B131SWCPpKTbv6+Rdym1eFlXtTODq4iaamy8Q+Lv6CvfGztoj9uCUV3JWTEfpYm8o
         pGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=dK18a6NEnGHo+IzSdMHBasBqOTV0j59qtMHNpA74JI8=;
        b=QbACKIMIW3+BnPj1B2hiMviT/J0WBFlpM0PFyTJxG4sJ3VDv0C+OWna0nKFajTgImM
         6a2SQYRlVnFaws0lK4PEYBiq57+NI919QkIo8kwH0MDjNA4VV3DB/qAqif7spg6Dv1w5
         J6MexSets+jGpz4blArHsWZV9Eit6Vl+q7J/glaANwE2pQAdfPfeiNpcizUVFFUxiqyu
         f3SR/fBalPWXnYJKogLGL/+9rl94bc1MvACkqSd5RJjgNtZHYx6cKqgSF9nBY/AzpUlX
         ZLKTY957UUG03pXoNB4lbfC3JJa+dzKYSd1QfASrYiyJzDaSCP1oRjyk01ljpb1/E8SD
         n+MA==
MIME-Version: 1.0
X-Gm-Message-State: AOAM530E5bDE+180WOCKoZeAXXszBSFVI9fV9MsjB3IAbKUOveO/JwIL
        C2QIZz6gsi4xe/F9/UCpGj5BgW8iZaTfJRjQi8djMLt3UBNd8dcQzeogMhLp82JKphSlTWQqmH7
        VnNJ+7Ty2y70fDBuCxQ==
X-Google-Smtp-Source: ABdhPJzX+C/KzyjoxZxB14gOE8MDQiCbN5MtEI/bU6o3NDsu9g6oebc1hSHvkNUtnw8HBuxItSov2g==
X-Received: by 2002:a63:1209:: with SMTP id h9mr8985452pgl.106.1629295942186;
        Wed, 18 Aug 2021 07:12:22 -0700 (PDT)
Received: from localhost.localdomain ([49.207.214.181])
        by smtp.gmail.com with ESMTPSA id e8sm8084343pgg.31.2021.08.18.07.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 07:12:21 -0700 (PDT)
From:   sidraya.bj@pathpartnertech.com
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     prashanth.ka@pathpartnertech.com, praneeth@ti.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        praveen.ap@pathpartnertech.com,
        Sidraya <sidraya.bj@pathpartnertech.com>
Subject: [PATCH 09/30] v4l: vxd-dec: Add idgen api modules
Date:   Wed, 18 Aug 2021 19:40:16 +0530
Message-Id: <20210818141037.19990-10-sidraya.bj@pathpartnertech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210818141037.19990-1-sidraya.bj@pathpartnertech.com>
References: <20210818141037.19990-1-sidraya.bj@pathpartnertech.com>
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sidraya <sidraya.bj@pathpartnertech.com>

This patch creates and destroy the context for idgen and
it returns ids, based on ids it manage the resources

Signed-off-by: Amit Makani <amit.makani@ti.com>
Signed-off-by: Sidraya <sidraya.bj@pathpartnertech.com>
---
 MAINTAINERS                                  |   2 +
 drivers/staging/media/vxd/common/idgen_api.c | 449 +++++++++++++++++++
 drivers/staging/media/vxd/common/idgen_api.h |  59 +++
 3 files changed, 510 insertions(+)
 create mode 100644 drivers/staging/media/vxd/common/idgen_api.c
 create mode 100644 drivers/staging/media/vxd/common/idgen_api.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 538faa644d13..0468aaac3b7d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19537,6 +19537,8 @@ M:	Sidraya Jayagond <sidraya.bj@pathpartnertech.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/img,d5520-vxd.yaml
+F:	drivers/staging/media/vxd/common/idgen_api.c
+F:	drivers/staging/media/vxd/common/idgen_api.h
 F:	drivers/staging/media/vxd/common/img_mem_man.c
 F:	drivers/staging/media/vxd/common/img_mem_man.h
 F:	drivers/staging/media/vxd/common/img_mem_unified.c
diff --git a/drivers/staging/media/vxd/common/idgen_api.c b/drivers/staging/media/vxd/common/idgen_api.c
new file mode 100644
index 000000000000..abc8660d7a4a
--- /dev/null
+++ b/drivers/staging/media/vxd/common/idgen_api.c
@@ -0,0 +1,449 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ID generation manager API.
+ *
+ * Copyright (c) Imagination Technologies Ltd.
+ * Copyright (c) 2021 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * Authors:
+ *	Amit Makani <amit.makani@ti.com>
+ *
+ * Re-written for upstreamimg
+ *	Sidraya Jayagond <sidraya.bj@pathpartnertech.com>
+ *	Prashanth Kumar Amai <prashanth.ka@pathpartnertech.com>
+ */
+
+#include <linux/dma-mapping.h>
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-mem2mem.h>
+
+#include "idgen_api.h"
+#include "lst.h"
+
+/*
+ * This structure contains ID context.
+ */
+struct idgen_context {
+	/* List of handle block structures */
+	struct lst_t hdlblklst;
+	/* Max ID - set by IDGEN_CreateContext(). */
+	unsigned int maxid;
+	/*
+	 * The number of handle per block. In case of
+	 * incrementing ids, size of the Hash table.
+	 */
+	unsigned int blksize;
+	/* Next free slot. */
+	unsigned int freeslot;
+	/* Max slot+1 for which we have allocated blocks. */
+	unsigned int maxslotplus1;
+	/* Incrementing ID's */
+	/* API needed to return incrementing IDs */
+	int incids;
+	/* Latest ID given back */
+	unsigned int latestincnumb;
+	/* Array of list to hold IDGEN_sHdlId */
+	struct lst_t *incidlist;
+};
+
+/*
+ * This structure represents internal representation of an Incrementing ID.
+ */
+struct idgen_id {
+	void **link; /* to be part of single linked list */
+	/* Incrementing ID returned */
+	unsigned int incid;
+	void *hid;
+};
+
+/*
+ * Structure contains the ID context.
+ */
+struct idgen_hdblk {
+	void **link; /* to be part of single linked list */
+	/* Array of handles in this block. */
+	void *ahhandles[1];
+};
+
+/*
+ * A hashing function could go here. Currently just makes a circular list of
+ * max number of concurrent Ids (idgen_context->blksize) in the system.
+ */
+static unsigned int idgen_func(struct idgen_context *idcontext, unsigned int id)
+{
+	return ((id - 1) % idcontext->blksize);
+}
+
+int idgen_createcontext(unsigned int maxid, unsigned int blksize,
+			int incid, void **idgenhandle)
+{
+	struct idgen_context *idcontext;
+
+	/* Create context structure */
+	idcontext = kzalloc(sizeof(*idcontext), GFP_KERNEL);
+	if (!idcontext)
+		return IMG_ERROR_OUT_OF_MEMORY;
+
+	/* InitIalise the context */
+	lst_init(&idcontext->hdlblklst);
+	idcontext->maxid   = maxid;
+	idcontext->blksize = blksize;
+
+	/* If we need incrementing Ids */
+	idcontext->incids = incid;
+	idcontext->latestincnumb = 0;
+	idcontext->incidlist  = NULL;
+	if (idcontext->incids) {
+		unsigned int i = 0;
+		/* Initialise the hash table of lists of length ui32BlkSize */
+		idcontext->incidlist = kzalloc((sizeof(*idcontext->incidlist) *
+				idcontext->blksize), GFP_KERNEL);
+		if (!idcontext->incidlist) {
+			kfree(idcontext);
+			return IMG_ERROR_OUT_OF_MEMORY;
+		}
+
+		/* Initialise all the lists in the hash table */
+		for (i = 0; i < idcontext->blksize; i++)
+			lst_init(&idcontext->incidlist[i]);
+	}
+
+	/* Return context structure as handle */
+	*idgenhandle = idcontext;
+
+	return IMG_SUCCESS;
+}
+
+int idgen_destroycontext(void *idgenhandle)
+{
+	struct idgen_context *idcontext = (struct idgen_context *)idgenhandle;
+	struct idgen_hdblk *hdblk;
+
+	if (!idcontext)
+		return IMG_ERROR_INVALID_PARAMETERS;
+
+	/* If incrementing Ids, free the List of Incrementing Ids */
+	if (idcontext->incids) {
+		struct idgen_id *id;
+		unsigned int i = 0;
+
+		for (i = 0; i < idcontext->blksize; i++) {
+			id = lst_removehead(&idcontext->incidlist[i]);
+			while (id) {
+				kfree(id);
+				id = lst_removehead(&idcontext->incidlist[i]);
+			}
+		}
+		kfree(idcontext->incidlist);
+	}
+
+	/* Remove and free all handle blocks */
+	hdblk = (struct idgen_hdblk *)lst_removehead(&idcontext->hdlblklst);
+	while (hdblk) {
+		kfree(hdblk);
+		hdblk = (struct idgen_hdblk *)
+				lst_removehead(&idcontext->hdlblklst);
+	}
+
+	/* Free context structure */
+	kfree(idcontext);
+
+	return IMG_SUCCESS;
+}
+
+static int idgen_findnextfreeslot(void *idgenhandle, unsigned int prevfreeslot)
+{
+	struct idgen_context *idcontext = (struct idgen_context *)idgenhandle;
+	struct idgen_hdblk *hdblk;
+	unsigned int freslotblk;
+	unsigned int freeslot;
+
+	if (!idcontext)
+		return IMG_ERROR_INVALID_PARAMETERS;
+
+	/* Find the block containing the current free slot */
+	freeslot	= prevfreeslot;
+	freslotblk = prevfreeslot;
+	hdblk = (struct idgen_hdblk *)lst_first(&idcontext->hdlblklst);
+	if (!hdblk)
+		return IMG_ERROR_FATAL;
+
+	while (freslotblk >= idcontext->blksize) {
+		freslotblk -= idcontext->blksize;
+		hdblk = (struct idgen_hdblk *)lst_next(hdblk);
+	}
+
+	/* Locate the next free slot */
+	while (hdblk) {
+		while (freslotblk < idcontext->blksize) {
+			if (!hdblk->ahhandles[freslotblk]) {
+				/* Found */
+				idcontext->freeslot = freeslot;
+				return IMG_SUCCESS;
+			}
+			freeslot++;
+			freslotblk++;
+		}
+		freslotblk = 0;
+		hdblk = (struct idgen_hdblk *)lst_next(hdblk);
+	}
+
+	/* Beyond the last block */
+	idcontext->freeslot = freeslot;
+	return IMG_SUCCESS;
+}
+
+/*
+ * This function returns ID structure (
+ */
+static struct idgen_id *idgen_getid(struct lst_t *idlist, unsigned int id)
+{
+	struct idgen_id *idstruct;
+
+	idstruct = lst_first(idlist);
+	while (idstruct) {
+		if (idstruct->incid == id)
+			break;
+
+		idstruct = lst_next(idstruct);
+	}
+	return idstruct;
+}
+
+/*
+ * This function does IDGEN allocation.
+ */
+int idgen_allocid(void *idgenhandle, void *handle, unsigned int *id)
+{
+	struct idgen_context *idcontext = (struct idgen_context *)idgenhandle;
+	struct idgen_hdblk *hdblk;
+	unsigned int size = 0;
+	unsigned int freeslot = 0;
+	unsigned int result = 0;
+
+	if (!idcontext || !handle)
+		return IMG_ERROR_INVALID_PARAMETERS;
+
+	if (!idcontext->incids) {
+		/* If the free slot is >= to the max id */
+		if (idcontext->freeslot >= idcontext->maxid) {
+			result = IMG_ERROR_INVALID_ID;
+			goto error;
+		}
+
+		/* If all of the allocated Ids have been used */
+		if (idcontext->freeslot >= idcontext->maxslotplus1) {
+			/* Allocate a stream context */
+			size = sizeof(*hdblk) + (sizeof(void *) *
+				(idcontext->blksize - 1));
+			hdblk = kzalloc(size, GFP_KERNEL);
+			if (!hdblk) {
+				result = IMG_ERROR_OUT_OF_MEMORY;
+				goto error;
+			}
+
+			lst_add(&idcontext->hdlblklst, hdblk);
+			idcontext->maxslotplus1 += idcontext->blksize;
+		}
+
+		/* Find the block containing the next free slot */
+		freeslot = idcontext->freeslot;
+		hdblk = (struct idgen_hdblk *)lst_first(&idcontext->hdlblklst);
+		if (!hdblk) {
+			result = IMG_ERROR_FATAL;
+			goto error;
+		}
+		while (freeslot >= idcontext->blksize) {
+			freeslot -= idcontext->blksize;
+			hdblk = (struct idgen_hdblk *)lst_next(hdblk);
+			if (!hdblk) {
+				result = IMG_ERROR_FATAL;
+				goto error;
+			}
+		}
+
+		/* Put handle in the next free slot */
+		hdblk->ahhandles[freeslot] = handle;
+
+		*id = idcontext->freeslot + 1;
+
+		/* Find a new free slot */
+		result = idgen_findnextfreeslot(idcontext, idcontext->freeslot);
+		if (result != 0)
+			goto error;
+	/*
+	 * If incrementing IDs, just add the ID node to the correct hash table
+	 * list.
+	 */
+	} else {
+		struct idgen_id *psid;
+		unsigned int currentincnum, funcid;
+		/*
+		 * If incrementing IDs, increment the id for returning back,and
+		 * save the ID node in the list of ids, indexed by hash function
+		 * (idgen_func). We might want to use a better hashing function
+		 */
+		currentincnum = (idcontext->latestincnumb + 1) %
+				idcontext->maxid;
+
+		/* Increment the id. Wraps if greater then Max Id */
+		if (currentincnum == 0)
+			currentincnum++;
+
+		idcontext->latestincnumb = currentincnum;
+
+		result = IMG_ERROR_INVALID_ID;
+		do {
+			/* Add to list in the correct hash table entry */
+			funcid = idgen_func(idcontext, idcontext->latestincnumb);
+			if (idgen_getid(&idcontext->incidlist[funcid],
+					idcontext->latestincnumb) == NULL) {
+				psid = kmalloc(sizeof(*psid), GFP_KERNEL);
+				if (!psid) {
+					result = IMG_ERROR_OUT_OF_MEMORY;
+					goto error;
+				}
+
+				psid->incid = idcontext->latestincnumb;
+				psid->hid = handle;
+
+				funcid = idgen_func(idcontext,
+						    idcontext->latestincnumb);
+				lst_add(&idcontext->incidlist[funcid],
+					psid);
+
+				result = IMG_SUCCESS;
+			} else {
+				idcontext->latestincnumb =
+					(idcontext->latestincnumb + 1) %
+						idcontext->maxid;
+				if (idcontext->latestincnumb == 0) {
+					/* Do not want to have zero as pic id */
+					idcontext->latestincnumb++;
+				}
+				/*
+				 * We have reached a point where we have wrapped
+				 * allowed Ids (MaxId) and we want to overwrite
+				 * ID still not released
+				 */
+				if (idcontext->latestincnumb == currentincnum)
+					goto error;
+			}
+		} while (result != IMG_SUCCESS);
+
+		*id = psid->incid;
+	}
+	return IMG_SUCCESS;
+error:
+	return result;
+}
+
+int idgen_freeid(void *idgenhandle, unsigned int id)
+{
+	struct idgen_context *idcontext = (struct idgen_context *)idgenhandle;
+	struct idgen_hdblk *hdblk;
+	unsigned int origslot;
+	unsigned int slot;
+
+	if (idcontext->incids) {
+		/*
+		 * Find the slot in the correct hash table entry, and
+		 * remove the ID.
+		 */
+		struct idgen_id *psid;
+
+		psid = idgen_getid(&idcontext->incidlist
+				[idgen_func(idcontext, id)], id);
+		if (psid) {
+			lst_remove(&idcontext->incidlist
+					[idgen_func(idcontext, id)], psid);
+			kfree(psid);
+		} else {
+			return IMG_ERROR_INVALID_ID;
+		}
+	} else {
+		/* If not incrementing id */
+		slot = id - 1;
+		origslot = slot;
+
+		if (slot >= idcontext->maxslotplus1)
+			return IMG_ERROR_INVALID_ID;
+
+		/* Find the block containing the id */
+		hdblk = (struct idgen_hdblk *)lst_first(&idcontext->hdlblklst);
+		if (!hdblk)
+			return IMG_ERROR_FATAL;
+
+		while (slot >= idcontext->blksize) {
+			slot -= idcontext->blksize;
+			hdblk = (struct idgen_hdblk *)lst_next(hdblk);
+			if (!hdblk)
+				return IMG_ERROR_FATAL;
+		}
+
+		/* Slot should be occupied */
+		if (!hdblk->ahhandles[slot])
+			return IMG_ERROR_INVALID_ID;
+
+		/* Free slot */
+		hdblk->ahhandles[slot] = NULL;
+
+		/* If this slot is before the previous free slot */
+		if ((origslot) < idcontext->freeslot)
+			idcontext->freeslot = origslot;
+	}
+	return IMG_SUCCESS;
+}
+
+int idgen_gethandle(void *idgenhandle, unsigned int id, void **handle)
+{
+	struct idgen_context *idcontext = (struct idgen_context *)idgenhandle;
+	struct idgen_hdblk *hdblk;
+	unsigned int slot;
+
+	if (!idcontext)
+		return IMG_ERROR_INVALID_PARAMETERS;
+
+	if (idcontext->incids) {
+		/*
+		 * Find the slot in the correct hash table entry, and return
+		 * the handles.
+		 */
+		struct idgen_id *psid;
+
+		psid = idgen_getid(&idcontext->incidlist
+				[idgen_func(idcontext, id)], id);
+		if (psid)
+			*handle = psid->hid;
+
+		else
+			return IMG_ERROR_INVALID_ID;
+	} else {
+		/* If not incrementing IDs */
+		slot = id - 1;
+		if (slot >= idcontext->maxslotplus1)
+			return IMG_ERROR_INVALID_ID;
+
+		/* Find the block containing the id */
+		hdblk = (struct idgen_hdblk *)lst_first(&idcontext->hdlblklst);
+		if (!hdblk)
+			return IMG_ERROR_INVALID_PARAMETERS;
+
+		while (slot >= idcontext->blksize) {
+			slot -= idcontext->blksize;
+			hdblk = (struct idgen_hdblk *)lst_next(hdblk);
+			if (!hdblk)
+				return IMG_ERROR_INVALID_PARAMETERS;
+		}
+
+		/* Slot should be occupied */
+		if (!hdblk->ahhandles[slot])
+			return IMG_ERROR_INVALID_ID;
+
+		/* Return the handle */
+		*handle = hdblk->ahhandles[slot];
+		}
+
+	return IMG_SUCCESS;
+}
diff --git a/drivers/staging/media/vxd/common/idgen_api.h b/drivers/staging/media/vxd/common/idgen_api.h
new file mode 100644
index 000000000000..6c894343f1fb
--- /dev/null
+++ b/drivers/staging/media/vxd/common/idgen_api.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * ID generation manager API.
+ *
+ * Copyright (c) Imagination Technologies Ltd.
+ * Copyright (c) 2021 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * Authors:
+ *	Amit Makani <amit.makani@ti.com>
+ *
+ * Re-written for upstreamimg
+ *	Sidraya Jayagond <sidraya.bj@pathpartnertech.com>
+ *	Prashanth Kumar Amai <prashanth.ka@pathpartnertech.com>
+ */
+#ifndef __IDGENAPI_H__
+#define __IDGENAPI_H__
+
+#include <linux/types.h>
+
+#include "img_errors.h"
+
+/*
+ * This function is used to create Id generation context.
+ * NOTE: Should only be called once to setup the context structure.
+ * NOTE: The client is responsible for providing thread/process safe locks on
+ * the context structure to maintain coherence.
+ */
+int idgen_createcontext(unsigned int maxid, unsigned int blksize,
+			int incid, void **idgenhandle);
+
+/*
+ * This function is used to destroy an Id generation context.  This function
+ * discards any handle blocks associated with the context.
+ * NOTE: The client is responsible for providing thread/process safe locks on
+ * the context structure to maintain coherence.
+ */
+int idgen_destroycontext(void *idgenhandle);
+
+/*
+ * This function is used to associate a handle with an Id.
+ * NOTE: The client is responsible for providing thread/process safe locks on
+ * the context structure to maintain coherency.
+ */
+int idgen_allocid(void *idgenhandle, void *handle, unsigned int *id);
+
+/*
+ * This function is used to free an Id.
+ * NOTE: The client is responsible for providing thread/process safe locks on
+ * the context structure to maintain coherency.
+ */
+int idgen_freeid(void *idgenhandle, unsigned int id);
+
+/*
+ * This function is used to get the handle associated with an Id.
+ * NOTE: The client is responsible for providing thread/process safe locks on
+ * the context structure to maintain coherency.
+ */
+int idgen_gethandle(void *idgenhandle, unsigned int id, void **handle);
+#endif /* __IDGENAPI_H__ */
-- 
2.17.1


-- 






This
message contains confidential information and is intended only 
for the
individual(s) named. If you are not the intended
recipient, you are 
notified that disclosing, copying, distributing or taking any
action in 
reliance on the contents of this mail and attached file/s is strictly
prohibited. Please notify the
sender immediately and delete this e-mail 
from your system. E-mail transmission
cannot be guaranteed to be secured or 
error-free as information could be
intercepted, corrupted, lost, destroyed, 
arrive late or incomplete, or contain
viruses. The sender therefore does 
not accept liability for any errors or
omissions in the contents of this 
message, which arise as a result of e-mail
transmission.
