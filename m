Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B21349746
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 17:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhCYQsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 12:48:07 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:43932 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhCYQrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 12:47:43 -0400
Received: by mail-io1-f52.google.com with SMTP id z136so2532556iof.10;
        Thu, 25 Mar 2021 09:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B+6Y/cobi5su9c2bhOqXxYIvs0Eb9dT8GgSbEmZKcCA=;
        b=gMXuTFbMUwVuzWmOnjiVe7nLeM3j76t1RM5ig8sXIiAw8hPh4ga6IVL4mjmOEWRNnQ
         eGiWP3HOvUjOi9nk1I5aphNuRmKAOiOlEcuQxNfRAJNGo5GPmQZgM73r9v4vIRpPPrrq
         8HlIv9v62WoZF7/ZkGRXICzvmkr3daJat68Y95DlI+vBgtCQEZregiFAWm82wAcy6UcH
         Ghj9Hz1cpP8/2QZeeVYnwHyVDtQDRUg+hvwryz6EI5m2VS/wfQdn9L3qXyzKA2FN+JZp
         KVJLtREs6KAHUfhmMP80OvVBCSqOoridu+65jmUGy5qrZZLUHHCF8nRWvEnGbPn6cU2o
         qJJg==
X-Gm-Message-State: AOAM531NvPWLSJlnFTO2WTwxPbmoZbs68abFknzEE8aQcOw2QarrIrDQ
        pcMPF2QLPD3Wzje5244xFGmhvzF2Lw==
X-Google-Smtp-Source: ABdhPJyIj0NMbzrI8nlMtHLjnNzmQnK6BAFfZVp2/OJSnEkaMmdiiKC++WuRsym6m0TlrYCvJuvBpw==
X-Received: by 2002:a6b:8b16:: with SMTP id n22mr7184339iod.79.1616690861409;
        Thu, 25 Mar 2021 09:47:41 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.253])
        by smtp.googlemail.com with ESMTPSA id h13sm2868615ila.82.2021.03.25.09.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 09:47:38 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 6/8] of: Fix kerneldoc output formatting
Date:   Thu, 25 Mar 2021 10:47:11 -0600
Message-Id: <20210325164713.1296407-7-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210325164713.1296407-1-robh@kernel.org>
References: <20210325164713.1296407-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The indentation of the kerneldoc comments affects the output formatting.
Leading tabs in particular don't work, and sections need to be indented
under the section header.

The example snippets for DT source in the comments still have some
formatting issues, but there doesn't seem to be any way to do multi-line
literal blocks in kerneldoc.

Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---

Note the dts examples still cause warnings. I couldn't find any way to 
do a literal block and fix them. Minimally, there needs to be a way to 
escape ':' and not create sections:

Documentation/devicetree/kernel-api:11: ../drivers/of/base.c:1466: WARNING: Definition list ends without a blank line; unexpected unindent.
Documentation/devicetree/kernel-api:11: ../drivers/of/base.c:1470: WARNING: Definition list ends without a blank line; unexpected unindent.
Documentation/devicetree/kernel-api:11: ../drivers/of/base.c:1474: WARNING: Definition list ends without a blank line; unexpected unindent.
Documentation/devicetree/kernel-api:11: ../drivers/of/base.c:1517: WARNING: Definition list ends without a blank line; unexpected unindent.
Documentation/devicetree/kernel-api:11: ../drivers/of/base.c:1521: WARNING: Definition list ends without a blank line; unexpected unindent.
Documentation/devicetree/kernel-api:11: ../drivers/of/base.c:1526: WARNING: Unexpected indentation.
Documentation/devicetree/kernel-api:11: ../drivers/of/base.c:1528: WARNING: Block quote ends without a blank line; unexpected unindent.
Documentation/devicetree/kernel-api:11: ../drivers/of/base.c:1529: WARNING: Definition list ends without a blank line; unexpected unindent.
Documentation/devicetree/kernel-api:11: ../drivers/of/base.c:1533: WARNING: Definition list ends without a blank line; unexpected unindent.
Documentation/devicetree/kernel-api:11: ../drivers/of/base.c:1705: WARNING: Definition list ends without a blank line; unexpected unindent.

 drivers/of/base.c | 284 +++++++++++++++++++++++-----------------------
 drivers/of/fdt.c  |   9 +-
 2 files changed, 145 insertions(+), 148 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 457d1ec27300..b06bcb3f001a 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -651,11 +651,11 @@ bool of_device_is_big_endian(const struct device_node *device)
 EXPORT_SYMBOL(of_device_is_big_endian);
 
 /**
- *	of_get_parent - Get a node's parent if any
- *	@node:	Node to get parent
+ * of_get_parent - Get a node's parent if any
+ * @node:	Node to get parent
  *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_get_parent(const struct device_node *node)
 {
@@ -673,15 +673,15 @@ struct device_node *of_get_parent(const struct device_node *node)
 EXPORT_SYMBOL(of_get_parent);
 
 /**
- *	of_get_next_parent - Iterate to a node's parent
- *	@node:	Node to get parent of
+ * of_get_next_parent - Iterate to a node's parent
+ * @node:	Node to get parent of
  *
- *	This is like of_get_parent() except that it drops the
- *	refcount on the passed node, making it suitable for iterating
- *	through a node's parents.
+ * This is like of_get_parent() except that it drops the
+ * refcount on the passed node, making it suitable for iterating
+ * through a node's parents.
  *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_get_next_parent(struct device_node *node)
 {
@@ -719,13 +719,13 @@ static struct device_node *__of_get_next_child(const struct device_node *node,
 	     child = __of_get_next_child(parent, child))
 
 /**
- *	of_get_next_child - Iterate a node childs
- *	@node:	parent node
- *	@prev:	previous child of the parent node, or NULL to get first
+ * of_get_next_child - Iterate a node childs
+ * @node:	parent node
+ * @prev:	previous child of the parent node, or NULL to get first
  *
- *	Returns a node pointer with refcount incremented, use of_node_put() on
- *	it when done. Returns NULL when prev is the last child. Decrements the
- *	refcount of prev.
+ * Return: A node pointer with refcount incremented, use of_node_put() on
+ * it when done. Returns NULL when prev is the last child. Decrements the
+ * refcount of prev.
  */
 struct device_node *of_get_next_child(const struct device_node *node,
 	struct device_node *prev)
@@ -741,12 +741,12 @@ struct device_node *of_get_next_child(const struct device_node *node,
 EXPORT_SYMBOL(of_get_next_child);
 
 /**
- *	of_get_next_available_child - Find the next available child node
- *	@node:	parent node
- *	@prev:	previous child of the parent node, or NULL to get first
+ * of_get_next_available_child - Find the next available child node
+ * @node:	parent node
+ * @prev:	previous child of the parent node, or NULL to get first
  *
- *      This function is like of_get_next_child(), except that it
- *      automatically skips any disabled nodes (i.e. status = "disabled").
+ * This function is like of_get_next_child(), except that it
+ * automatically skips any disabled nodes (i.e. status = "disabled").
  */
 struct device_node *of_get_next_available_child(const struct device_node *node,
 	struct device_node *prev)
@@ -772,12 +772,12 @@ struct device_node *of_get_next_available_child(const struct device_node *node,
 EXPORT_SYMBOL(of_get_next_available_child);
 
 /**
- *	of_get_next_cpu_node - Iterate on cpu nodes
- *	@prev:	previous child of the /cpus node, or NULL to get first
+ * of_get_next_cpu_node - Iterate on cpu nodes
+ * @prev:	previous child of the /cpus node, or NULL to get first
  *
- *	Returns a cpu node pointer with refcount incremented, use of_node_put()
- *	on it when done. Returns NULL when prev is the last child. Decrements
- *	the refcount of prev.
+ * Return: A cpu node pointer with refcount incremented, use of_node_put()
+ * on it when done. Returns NULL when prev is the last child. Decrements
+ * the refcount of prev.
  */
 struct device_node *of_get_next_cpu_node(struct device_node *prev)
 {
@@ -834,15 +834,15 @@ struct device_node *of_get_compatible_child(const struct device_node *parent,
 EXPORT_SYMBOL(of_get_compatible_child);
 
 /**
- *	of_get_child_by_name - Find the child node by name for a given parent
- *	@node:	parent node
- *	@name:	child name to look for.
+ * of_get_child_by_name - Find the child node by name for a given parent
+ * @node:	parent node
+ * @name:	child name to look for.
  *
- *      This function looks for child node for given matching name
+ * This function looks for child node for given matching name
  *
- *	Returns a node pointer if found, with refcount incremented, use
- *	of_node_put() on it when done.
- *	Returns NULL if node is not found.
+ * Return: A node pointer if found, with refcount incremented, use
+ * of_node_put() on it when done.
+ * Returns NULL if node is not found.
  */
 struct device_node *of_get_child_by_name(const struct device_node *node,
 				const char *name)
@@ -893,22 +893,22 @@ struct device_node *__of_find_node_by_full_path(struct device_node *node,
 }
 
 /**
- *	of_find_node_opts_by_path - Find a node matching a full OF path
- *	@path: Either the full path to match, or if the path does not
- *	       start with '/', the name of a property of the /aliases
- *	       node (an alias).  In the case of an alias, the node
- *	       matching the alias' value will be returned.
- *	@opts: Address of a pointer into which to store the start of
- *	       an options string appended to the end of the path with
- *	       a ':' separator.
- *
- *	Valid paths:
- *		/foo/bar	Full path
- *		foo		Valid alias
- *		foo/bar		Valid alias + relative path
- *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * of_find_node_opts_by_path - Find a node matching a full OF path
+ * @path: Either the full path to match, or if the path does not
+ *       start with '/', the name of a property of the /aliases
+ *       node (an alias).  In the case of an alias, the node
+ *       matching the alias' value will be returned.
+ * @opts: Address of a pointer into which to store the start of
+ *       an options string appended to the end of the path with
+ *       a ':' separator.
+ *
+ * Valid paths:
+ *  * /foo/bar	Full path
+ *  * foo	Valid alias
+ *  * foo/bar	Valid alias + relative path
+ *
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_find_node_opts_by_path(const char *path, const char **opts)
 {
@@ -958,15 +958,15 @@ struct device_node *of_find_node_opts_by_path(const char *path, const char **opt
 EXPORT_SYMBOL(of_find_node_opts_by_path);
 
 /**
- *	of_find_node_by_name - Find a node by its "name" property
- *	@from:	The node to start searching from or NULL; the node
+ * of_find_node_by_name - Find a node by its "name" property
+ * @from:	The node to start searching from or NULL; the node
  *		you pass will not be searched, only the next one
  *		will. Typically, you pass what the previous call
  *		returned. of_node_put() will be called on @from.
- *	@name:	The name string to match against
+ * @name:	The name string to match against
  *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_find_node_by_name(struct device_node *from,
 	const char *name)
@@ -985,16 +985,16 @@ struct device_node *of_find_node_by_name(struct device_node *from,
 EXPORT_SYMBOL(of_find_node_by_name);
 
 /**
- *	of_find_node_by_type - Find a node by its "device_type" property
- *	@from:	The node to start searching from, or NULL to start searching
+ * of_find_node_by_type - Find a node by its "device_type" property
+ * @from:	The node to start searching from, or NULL to start searching
  *		the entire device tree. The node you pass will not be
  *		searched, only the next one will; typically, you pass
  *		what the previous call returned. of_node_put() will be
  *		called on from for you.
- *	@type:	The type string to match against
+ * @type:	The type string to match against
  *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_find_node_by_type(struct device_node *from,
 	const char *type)
@@ -1013,18 +1013,18 @@ struct device_node *of_find_node_by_type(struct device_node *from,
 EXPORT_SYMBOL(of_find_node_by_type);
 
 /**
- *	of_find_compatible_node - Find a node based on type and one of the
+ * of_find_compatible_node - Find a node based on type and one of the
  *                                tokens in its "compatible" property
- *	@from:		The node to start searching from or NULL, the node
- *			you pass will not be searched, only the next one
- *			will; typically, you pass what the previous call
- *			returned. of_node_put() will be called on it
- *	@type:		The type string to match "device_type" or NULL to ignore
- *	@compatible:	The string to match to one of the tokens in the device
- *			"compatible" list.
- *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * @from:	The node to start searching from or NULL, the node
+ *		you pass will not be searched, only the next one
+ *		will; typically, you pass what the previous call
+ *		returned. of_node_put() will be called on it
+ * @type:	The type string to match "device_type" or NULL to ignore
+ * @compatible:	The string to match to one of the tokens in the device
+ *		"compatible" list.
+ *
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_find_compatible_node(struct device_node *from,
 	const char *type, const char *compatible)
@@ -1044,16 +1044,16 @@ struct device_node *of_find_compatible_node(struct device_node *from,
 EXPORT_SYMBOL(of_find_compatible_node);
 
 /**
- *	of_find_node_with_property - Find a node which has a property with
- *                                   the given name.
- *	@from:		The node to start searching from or NULL, the node
- *			you pass will not be searched, only the next one
- *			will; typically, you pass what the previous call
- *			returned. of_node_put() will be called on it
- *	@prop_name:	The name of the property to look for.
- *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * of_find_node_with_property - Find a node which has a property with
+ *                              the given name.
+ * @from:	The node to start searching from or NULL, the node
+ *		you pass will not be searched, only the next one
+ *		will; typically, you pass what the previous call
+ *		returned. of_node_put() will be called on it
+ * @prop_name:	The name of the property to look for.
+ *
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_find_node_with_property(struct device_node *from,
 	const char *prop_name)
@@ -1102,10 +1102,10 @@ const struct of_device_id *__of_match_node(const struct of_device_id *matches,
 
 /**
  * of_match_node - Tell if a device_node has a matching of_match structure
- *	@matches:	array of of device match structures to search in
- *	@node:		the of device structure to match against
+ * @matches:	array of of device match structures to search in
+ * @node:	the of device structure to match against
  *
- *	Low level utility function used by device matching.
+ * Low level utility function used by device matching.
  */
 const struct of_device_id *of_match_node(const struct of_device_id *matches,
 					 const struct device_node *node)
@@ -1121,17 +1121,17 @@ const struct of_device_id *of_match_node(const struct of_device_id *matches,
 EXPORT_SYMBOL(of_match_node);
 
 /**
- *	of_find_matching_node_and_match - Find a node based on an of_device_id
- *					  match table.
- *	@from:		The node to start searching from or NULL, the node
- *			you pass will not be searched, only the next one
- *			will; typically, you pass what the previous call
- *			returned. of_node_put() will be called on it
- *	@matches:	array of of device match structures to search in
- *	@match:		Updated to point at the matches entry which matched
- *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
+ * of_find_matching_node_and_match - Find a node based on an of_device_id
+ *				     match table.
+ * @from:	The node to start searching from or NULL, the node
+ *		you pass will not be searched, only the next one
+ *		will; typically, you pass what the previous call
+ *		returned. of_node_put() will be called on it
+ * @matches:	array of of device match structures to search in
+ * @match:	Updated to point at the matches entry which matched
+ *
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
  */
 struct device_node *of_find_matching_node_and_match(struct device_node *from,
 					const struct of_device_id *matches,
@@ -1462,20 +1462,20 @@ EXPORT_SYMBOL(of_parse_phandle);
  *
  * Example:
  *
- * phandle1: node1 {
+ *  phandle1: node1 {
  *	#list-cells = <2>;
- * }
+ *  };
  *
- * phandle2: node2 {
+ *  phandle2: node2 {
  *	#list-cells = <1>;
- * }
+ *  };
  *
- * node3 {
+ *  node3 {
  *	list = <&phandle1 1 2 &phandle2 3>;
- * }
+ *  };
  *
- * To get a device_node of the `node2' node you may call this:
- * of_parse_phandle_with_args(node3, "list", "#list-cells", 1, &args);
+ *  To get a device_node of the ``node2`` node you may call this:
+ *  of_parse_phandle_with_args(node3, "list", "#list-cells", 1, &args);
  */
 int of_parse_phandle_with_args(const struct device_node *np, const char *list_name,
 				const char *cells_name, int index,
@@ -1513,29 +1513,28 @@ EXPORT_SYMBOL(of_parse_phandle_with_args);
  * pointer.
  *
  * Example:
- *
- * phandle1: node1 {
- *	#list-cells = <2>;
- * }
- *
- * phandle2: node2 {
- *	#list-cells = <1>;
- * }
- *
- * phandle3: node3 {
- * 	#list-cells = <1>;
- * 	list-map = <0 &phandle2 3>,
- * 		   <1 &phandle2 2>,
- * 		   <2 &phandle1 5 1>;
- *	list-map-mask = <0x3>;
- * };
- *
- * node4 {
- *	list = <&phandle1 1 2 &phandle3 0>;
- * }
- *
- * To get a device_node of the `node2' node you may call this:
- * of_parse_phandle_with_args(node4, "list", "list", 1, &args);
+ *  phandle1: node1 {
+ *  	#list-cells = <2>;
+ *  };
+ *
+ *  phandle2: node2 {
+ *  	#list-cells = <1>;
+ *  };
+ *
+ *  phandle3: node3 {
+ *  	#list-cells = <1>;
+ *  	list-map = <0 &phandle2 3>,
+ *  		   <1 &phandle2 2>,
+ *  		   <2 &phandle1 5 1>;
+ *  	list-map-mask = <0x3>;
+ *  };
+ *
+ *  node4 {
+ *  	list = <&phandle1 1 2 &phandle3 0>;
+ *  };
+ *
+ *  To get a device_node of the ``node2`` node you may call this:
+ *  of_parse_phandle_with_args(node4, "list", "list", 1, &args);
  */
 int of_parse_phandle_with_args_map(const struct device_node *np,
 				   const char *list_name,
@@ -1696,18 +1695,18 @@ EXPORT_SYMBOL(of_parse_phandle_with_args_map);
  *
  * Example:
  *
- * phandle1: node1 {
- * }
+ *  phandle1: node1 {
+ *  };
  *
- * phandle2: node2 {
- * }
+ *  phandle2: node2 {
+ *  };
  *
- * node3 {
- *	list = <&phandle1 0 2 &phandle2 2 3>;
- * }
+ *  node3 {
+ *  	list = <&phandle1 0 2 &phandle2 2 3>;
+ *  };
  *
- * To get a device_node of the `node2' node you may call this:
- * of_parse_phandle_with_fixed_args(node3, "list", 2, 1, &args);
+ *  To get a device_node of the ``node2`` node you may call this:
+ *  of_parse_phandle_with_fixed_args(node3, "list", 2, 1, &args);
  */
 int of_parse_phandle_with_fixed_args(const struct device_node *np,
 				const char *list_name, int cell_count,
@@ -1952,13 +1951,12 @@ static void of_alias_add(struct alias_prop *ap, struct device_node *np,
 
 /**
  * of_alias_scan - Scan all properties of the 'aliases' node
+ * @dt_alloc:	An allocator that provides a virtual address to memory
+ *		for storing the resulting tree
  *
  * The function scans all the properties of the 'aliases' node and populates
  * the global lookup table with the properties.  It returns the
  * number of alias properties found, or an error code in case of failure.
- *
- * @dt_alloc:	An allocator that provides a virtual address to memory
- *		for storing the resulting tree
  */
 void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
 {
@@ -2153,12 +2151,12 @@ bool of_console_check(struct device_node *dn, char *name, int index)
 EXPORT_SYMBOL_GPL(of_console_check);
 
 /**
- *	of_find_next_cache_node - Find a node's subsidiary cache
- *	@np:	node of type "cpu" or "cache"
+ * of_find_next_cache_node - Find a node's subsidiary cache
+ * @np:	node of type "cpu" or "cache"
  *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.  Caller should hold a reference
- *	to np.
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.  Caller should hold a reference
+ * to np.
  */
 struct device_node *of_find_next_cache_node(const struct device_node *np)
 {
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 4d6d195e089a..ba53da9c3895 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -349,11 +349,6 @@ static int unflatten_dt_nodes(const void *blob,
 
 /**
  * __unflatten_device_tree - create tree of device_nodes from flat blob
- *
- * unflattens a device-tree, creating the
- * tree of struct device_node. It also fills the "name" and "type"
- * pointers of the nodes so the normal device-tree walking functions
- * can be used.
  * @blob: The blob to expand
  * @dad: Parent device node
  * @mynodes: The device_node tree created by the call
@@ -361,6 +356,10 @@ static int unflatten_dt_nodes(const void *blob,
  * for the resulting tree
  * @detached: if true set OF_DETACHED on @mynodes
  *
+ * unflattens a device-tree, creating the tree of struct device_node. It also
+ * fills the "name" and "type" pointers of the nodes so the normal device-tree
+ * walking functions can be used.
+ *
  * Returns NULL on failure or the memory chunk containing the unflattened
  * device tree on success.
  */
-- 
2.27.0

