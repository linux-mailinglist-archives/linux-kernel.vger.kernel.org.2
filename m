Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0EE349747
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 17:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhCYQsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 12:48:09 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:44902 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhCYQrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 12:47:48 -0400
Received: by mail-io1-f44.google.com with SMTP id v26so2534017iox.11;
        Thu, 25 Mar 2021 09:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KBYoERx0ba+tILGow9NRBaJoRdq1lnJM67cm++2N4QA=;
        b=b96lKvQragKOF+mUreYqFbv1U11Jnw1rXy8GL2vDtDOqgHLn+mf0ZJPq24C+6Pl7Ii
         v6igby0Wob/mn2AvrROl2OqOpL2Frn3bZCd142JoEA5E4KVIR3BJiP1bj6JRjlvOP9q6
         aSpfINx8QtomihlxxmxlPePZ5CvREzy8KHa3jHe3PC6cSUBxPEqHHd0oqME0KlsXnIaE
         4MoBYPch5Ig+DRfPTyKngZZc8ewJgOSztEqdjzzA+gmhX3qhMCN5U3Nu9+avojJTd6zu
         p8hWZlXE/k25Jr3hKT7wS5y0RCySWb9ky1cJ40mfc0XFRRD8TeWd+mu/cdwz5o9TtzZC
         KGRQ==
X-Gm-Message-State: AOAM533S9/KwBfs99sYAybL/Y+HuB+HXqtqxrMTR3mQ5LQ5UcZK1fora
        XrgrPLaLSNyFuifTfn7li37XunHEPA==
X-Google-Smtp-Source: ABdhPJx+n4nBN2Y8WtHUTpBoUfMYC3FWEM/UaMlW3xER5uHXBH9E+L4ABFI1IxpMndN+c0qN9nscYw==
X-Received: by 2002:a6b:b7cd:: with SMTP id h196mr6928415iof.59.1616690865811;
        Thu, 25 Mar 2021 09:47:45 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.253])
        by smtp.googlemail.com with ESMTPSA id h13sm2868615ila.82.2021.03.25.09.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 09:47:43 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 7/8] of: Add missing 'Return' section in kerneldoc comments
Date:   Thu, 25 Mar 2021 10:47:12 -0600
Message-Id: <20210325164713.1296407-8-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210325164713.1296407-1-robh@kernel.org>
References: <20210325164713.1296407-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many of the DT kerneldoc comments are lacking a 'Return' section. Let's
add the section in cases we have a description of return values. There's
still some cases where the return values are not documented.

Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/base.c     | 39 +++++++++++++------------
 drivers/of/dynamic.c  | 19 ++++++++-----
 drivers/of/fdt.c      |  8 +++---
 drivers/of/irq.c      | 14 ++++-----
 drivers/of/overlay.c  | 16 +++++------
 drivers/of/platform.c | 10 +++----
 drivers/of/property.c | 66 +++++++++++++++++++++++++++----------------
 include/linux/of.h    | 63 ++++++++++++++++++++++++++---------------
 8 files changed, 140 insertions(+), 95 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index b06bcb3f001a..3bf189d394bd 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -244,7 +244,7 @@ struct device_node *__of_find_all_nodes(struct device_node *prev)
  * @prev:	Previous node or NULL to start iteration
  *		of_node_put() will be called on it
  *
- * Returns a node pointer with refcount incremented, use
+ * Return: A node pointer with refcount incremented, use
  * of_node_put() on it when done.
  */
 struct device_node *of_find_all_nodes(struct device_node *prev)
@@ -374,7 +374,7 @@ bool __weak arch_find_n_match_cpu_physical_id(struct device_node *cpun,
  * before booting secondary cores. This function uses arch_match_cpu_phys_id
  * which can be overridden by architecture specific implementation.
  *
- * Returns a node pointer for the logical cpu with refcount incremented, use
+ * Return: A node pointer for the logical cpu with refcount incremented, use
  * of_node_put() on it when done. Returns NULL if not found.
  */
 struct device_node *of_get_cpu_node(int cpu, unsigned int *thread)
@@ -394,8 +394,8 @@ EXPORT_SYMBOL(of_get_cpu_node);
  *
  * @cpu_node: Pointer to the device_node for CPU.
  *
- * Returns the logical CPU number of the given CPU device_node.
- * Returns -ENODEV if the CPU is not found.
+ * Return: The logical CPU number of the given CPU device_node or -ENODEV if the
+ * CPU is not found.
  */
 int of_cpu_node_to_id(struct device_node *cpu_node)
 {
@@ -427,7 +427,7 @@ EXPORT_SYMBOL(of_cpu_node_to_id);
  * bindings. This function check for both and returns the idle state node for
  * the requested index.
  *
- * In case an idle state node is found at @index, the refcount is incremented
+ * Return: An idle state node if found at @index. The refcount is incremented
  * for it, so call of_node_put() on it when done. Returns NULL if not found.
  */
 struct device_node *of_get_cpu_state_node(struct device_node *cpu_node,
@@ -561,7 +561,7 @@ int of_device_compatible_match(struct device_node *device,
  * of_machine_is_compatible - Test root of device tree for a given compatible value
  * @compat: compatible string to look for in root node's compatible property.
  *
- * Returns a positive integer if the root node has the given value in its
+ * Return: A positive integer if the root node has the given value in its
  * compatible property.
  */
 int of_machine_is_compatible(const char *compat)
@@ -583,7 +583,7 @@ EXPORT_SYMBOL(of_machine_is_compatible);
  *
  *  @device: Node to check for availability, with locks already held
  *
- *  Returns true if the status property is absent or set to "okay" or "ok",
+ *  Return: True if the status property is absent or set to "okay" or "ok",
  *  false otherwise
  */
 static bool __of_device_is_available(const struct device_node *device)
@@ -611,7 +611,7 @@ static bool __of_device_is_available(const struct device_node *device)
  *
  *  @device: Node to check for availability
  *
- *  Returns true if the status property is absent or set to "okay" or "ok",
+ *  Return: True if the status property is absent or set to "okay" or "ok",
  *  false otherwise
  */
 bool of_device_is_available(const struct device_node *device)
@@ -632,7 +632,7 @@ EXPORT_SYMBOL(of_device_is_available);
  *
  *  @device: Node to check for endianness
  *
- *  Returns true if the device has a "big-endian" property, or if the kernel
+ *  Return: True if the device has a "big-endian" property, or if the kernel
  *  was compiled for BE *and* the device has a "native-endian" property.
  *  Returns false otherwise.
  *
@@ -816,7 +816,7 @@ EXPORT_SYMBOL(of_get_next_cpu_node);
  * Lookup child node whose compatible property contains the given compatible
  * string.
  *
- * Returns a node pointer with refcount incremented, use of_node_put() on it
+ * Return: a node pointer with refcount incremented, use of_node_put() on it
  * when done; or NULL if not found.
  */
 struct device_node *of_get_compatible_child(const struct device_node *parent,
@@ -1170,7 +1170,7 @@ EXPORT_SYMBOL(of_find_matching_node_and_match);
  * It does this by stripping the manufacturer prefix (as delimited by a ',')
  * from the first entry in the compatible list property.
  *
- * This routine returns 0 on success, <0 on failure.
+ * Return: This routine returns 0 on success, <0 on failure.
  */
 int of_modalias_node(struct device_node *node, char *modalias, int len)
 {
@@ -1190,7 +1190,7 @@ EXPORT_SYMBOL_GPL(of_modalias_node);
  * of_find_node_by_phandle - Find a node given a phandle
  * @handle:	phandle of the node to find
  *
- * Returns a node pointer with refcount incremented, use
+ * Return: A node pointer with refcount incremented, use
  * of_node_put() on it when done.
  */
 struct device_node *of_find_node_by_phandle(phandle handle)
@@ -1426,7 +1426,7 @@ static int __of_parse_phandle_with_args(const struct device_node *np,
  * @index: For properties holding a table of phandles, this is the index into
  *         the table
  *
- * Returns the device_node pointer with refcount incremented.  Use
+ * Return: The device_node pointer with refcount incremented.  Use
  * of_node_put() on it when done.
  */
 struct device_node *of_parse_phandle(const struct device_node *np,
@@ -1725,7 +1725,7 @@ EXPORT_SYMBOL(of_parse_phandle_with_fixed_args);
  * @list_name:	property name that contains a list
  * @cells_name:	property name that specifies phandles' arguments count
  *
- * Returns the number of phandle + argument tuples within a property. It
+ * Return: The number of phandle + argument tuples within a property. It
  * is a typical pattern to encode a list of phandle and variable
  * arguments into a single property. The number of arguments is encoded
  * by a property in the phandle-target node. For example, a gpios
@@ -2025,7 +2025,9 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
  * @stem:	Alias stem of the given device_node
  *
  * The function travels the lookup table to get the alias id for the given
- * device_node and alias stem.  It returns the alias id if found.
+ * device_node and alias stem.
+ *
+ * Return: The alias id if found.
  */
 int of_alias_get_id(struct device_node *np, const char *stem)
 {
@@ -2134,8 +2136,9 @@ EXPORT_SYMBOL_GPL(of_alias_get_highest_id);
  * @index: Index to use for preferred console.
  *
  * Check if the given device node matches the stdout-path property in the
- * /chosen node. If it does then register it as the preferred console and return
- * TRUE. Otherwise return FALSE.
+ * /chosen node. If it does then register it as the preferred console.
+ *
+ * Return: TRUE if console successfully setup. Otherwise return FALSE.
  */
 bool of_console_check(struct device_node *dn, char *name, int index)
 {
@@ -2186,7 +2189,7 @@ struct device_node *of_find_next_cache_node(const struct device_node *np)
  *
  * @cpu: cpu number(logical index) for which the last cache level is needed
  *
- * Returns the the level at which the last cache is present. It is exactly
+ * Return: The the level at which the last cache is present. It is exactly
  * same as  the total number of cache levels for the given logical cpu.
  */
 int of_find_last_cache_level(unsigned int cpu)
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 1d7a22e44d78..cd3821a6444f 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -27,7 +27,7 @@ static struct device_node *kobj_to_device_node(struct kobject *kobj)
  * @node:	Node to inc refcount, NULL is supported to simplify writing of
  *		callers
  *
- * Returns node.
+ * Return: The node with refcount incremented.
  */
 struct device_node *of_node_get(struct device_node *node)
 {
@@ -104,7 +104,8 @@ int of_reconfig_notify(unsigned long action, struct of_reconfig_data *p)
  * @arg		- argument of the of notifier
  *
  * Returns the new state of a device based on the notifier used.
- * Returns 0 on device going from enabled to disabled, 1 on device
+ *
+ * Return: 0 on device going from enabled to disabled, 1 on device
  * going from disabled to enabled and -1 on no change.
  */
 int of_reconfig_get_state_change(unsigned long action, struct of_reconfig_data *pr)
@@ -374,7 +375,8 @@ void of_node_release(struct kobject *kobj)
  * property structure and the property name & contents. The property's
  * flags have the OF_DYNAMIC bit set so that we can differentiate between
  * dynamically allocated properties and not.
- * Returns the newly allocated property or NULL on out of memory error.
+ *
+ * Return: The newly allocated property or NULL on out of memory error.
  */
 struct property *__of_prop_dup(const struct property *prop, gfp_t allocflags)
 {
@@ -417,7 +419,7 @@ struct property *__of_prop_dup(const struct property *prop, gfp_t allocflags)
  * another node.  The node data are dynamically allocated and all the node
  * flags have the OF_DYNAMIC & OF_DETACHED bits set.
  *
- * Returns the newly allocated node or NULL on out of memory error.
+ * Return: The newly allocated node or NULL on out of memory error.
  */
 struct device_node *__of_node_dup(const struct device_node *np,
 				  const char *full_name)
@@ -783,7 +785,8 @@ static int __of_changeset_apply(struct of_changeset *ocs)
  * Any side-effects of live tree state changes are applied here on
  * success, like creation/destruction of devices and side-effects
  * like creation of sysfs properties and directories.
- * Returns 0 on success, a negative error value in case of an error.
+ *
+ * Return: 0 on success, a negative error value in case of an error.
  * On error the partially applied effects are reverted.
  */
 int of_changeset_apply(struct of_changeset *ocs)
@@ -877,7 +880,8 @@ static int __of_changeset_revert(struct of_changeset *ocs)
  * was before the application.
  * Any side-effects like creation/destruction of devices and
  * removal of sysfs properties and directories are applied.
- * Returns 0 on success, a negative error value in case of an error.
+ *
+ * Return: 0 on success, a negative error value in case of an error.
  */
 int of_changeset_revert(struct of_changeset *ocs)
 {
@@ -905,7 +909,8 @@ EXPORT_SYMBOL_GPL(of_changeset_revert);
  * + OF_RECONFIG_ADD_PROPERTY
  * + OF_RECONFIG_REMOVE_PROPERTY,
  * + OF_RECONFIG_UPDATE_PROPERTY
- * Returns 0 on success, a negative error value in case of an error.
+ *
+ * Return: 0 on success, a negative error value in case of an error.
  */
 int of_changeset_action(struct of_changeset *ocs, unsigned long action,
 		struct device_node *np, struct property *prop)
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index ba53da9c3895..134c7fb43a14 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -282,7 +282,7 @@ static void reverse_nodes(struct device_node *parent)
  * @dad: Parent struct device_node
  * @nodepp: The device_node tree created by the call
  *
- * It returns the size of unflattened device tree or error code
+ * Return: The size of unflattened device tree or error code
  */
 static int unflatten_dt_nodes(const void *blob,
 			      void *mem,
@@ -360,7 +360,7 @@ static int unflatten_dt_nodes(const void *blob,
  * fills the "name" and "type" pointers of the nodes so the normal device-tree
  * walking functions can be used.
  *
- * Returns NULL on failure or the memory chunk containing the unflattened
+ * Return: NULL on failure or the memory chunk containing the unflattened
  * device tree on success.
  */
 void *__unflatten_device_tree(const void *blob,
@@ -441,7 +441,7 @@ static DEFINE_MUTEX(of_fdt_unflatten_mutex);
  * pointers of the nodes so the normal device-tree walking functions
  * can be used.
  *
- * Returns NULL on failure or the memory chunk containing the unflattened
+ * Return: NULL on failure or the memory chunk containing the unflattened
  * device tree on success.
  */
 void *of_fdt_unflatten_tree(const unsigned long *blob,
@@ -716,7 +716,7 @@ const void *__init of_get_flat_dt_prop(unsigned long node, const char *name,
  * @node: node to test
  * @compat: compatible string to compare with compatible list.
  *
- * On match, returns a non-zero value with smaller values returned for more
+ * Return: a non-zero value on match with smaller values returned for more
  * specific compatible values.
  */
 static int of_fdt_is_compatible(const void *blob,
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 25d17b8a1a1a..352e14b007e7 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -48,7 +48,7 @@ EXPORT_SYMBOL_GPL(irq_of_parse_and_map);
  * of_irq_find_parent - Given a device node, find its interrupt parent node
  * @child: pointer to device node
  *
- * Returns a pointer to the interrupt parent node, or NULL if the interrupt
+ * Return: A pointer to the interrupt parent node, or NULL if the interrupt
  * parent could not be determined.
  */
 struct device_node *of_irq_find_parent(struct device_node *child)
@@ -81,14 +81,14 @@ EXPORT_SYMBOL_GPL(of_irq_find_parent);
  * @addr:	address specifier (start of "reg" property of the device) in be32 format
  * @out_irq:	structure of_phandle_args updated by this function
  *
- * Returns 0 on success and a negative number on error
- *
  * This function is a low-level interrupt tree walking function. It
  * can be used to do a partial walk with synthetized reg and interrupts
  * properties, for example when resolving PCI interrupts when no device
  * node exist for the parent. It takes an interrupt specifier structure as
  * input, walks the tree looking for any interrupt-map properties, translates
  * the specifier for each map, and then returns the translated map.
+ *
+ * Return: 0 on success and a negative number on error
  */
 int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 {
@@ -380,7 +380,7 @@ EXPORT_SYMBOL_GPL(of_irq_to_resource);
  * @dev: pointer to device tree node
  * @index: zero-based index of the IRQ
  *
- * Returns Linux IRQ number on success, or 0 on the IRQ mapping failure, or
+ * Return: Linux IRQ number on success, or 0 on the IRQ mapping failure, or
  * -EPROBE_DEFER if the IRQ domain is not yet created, or error code in case
  * of any other failure.
  */
@@ -407,7 +407,7 @@ EXPORT_SYMBOL_GPL(of_irq_get);
  * @dev: pointer to device tree node
  * @name: IRQ name
  *
- * Returns Linux IRQ number on success, or 0 on the IRQ mapping failure, or
+ * Return: Linux IRQ number on success, or 0 on the IRQ mapping failure, or
  * -EPROBE_DEFER if the IRQ domain is not yet created, or error code in case
  * of any other failure.
  */
@@ -447,7 +447,7 @@ int of_irq_count(struct device_node *dev)
  * @res: array of resources to fill in
  * @nr_irqs: the number of IRQs (and upper bound for num of @res elements)
  *
- * Returns the size of the filled in table (up to @nr_irqs).
+ * Return: The size of the filled in table (up to @nr_irqs).
  */
 int of_irq_to_resource_table(struct device_node *dev, struct resource *res,
 		int nr_irqs)
@@ -602,7 +602,7 @@ static u32 __of_msi_map_id(struct device *dev, struct device_node **np,
  * Walk up the device hierarchy looking for devices with a "msi-map"
  * property.  If found, apply the mapping to @id_in.
  *
- * Returns the mapped MSI ID.
+ * Return: The mapped MSI ID.
  */
 u32 of_msi_map_id(struct device *dev, struct device_node *msi_np, u32 id_in)
 {
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index c25679f7bd3f..d241273170fd 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -298,7 +298,7 @@ static struct property *dup_and_fixup_symbol_prop(
  *
  * Update of property in symbols node is not allowed.
  *
- * Returns 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
+ * Return: 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
  * invalid @overlay.
  */
 static int add_changeset_property(struct overlay_changeset *ovcs,
@@ -403,7 +403,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
  *
  * NOTE_2: Multiple mods of created nodes not supported.
  *
- * Returns 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
+ * Return: 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
  * invalid @overlay.
  */
 static int add_changeset_node(struct overlay_changeset *ovcs,
@@ -475,7 +475,7 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
  *
  * Do not allow symbols node to have any children.
  *
- * Returns 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
+ * Return: 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
  * invalid @overlay_node.
  */
 static int build_changeset_next_level(struct overlay_changeset *ovcs,
@@ -606,7 +606,7 @@ static int find_dup_cset_prop(struct overlay_changeset *ovcs,
  * the same node or duplicate {add, delete, or update} properties entries
  * for the same property.
  *
- * Returns 0 on success, or -EINVAL if duplicate changeset entry found.
+ * Return: 0 on success, or -EINVAL if duplicate changeset entry found.
  */
 static int changeset_dup_entry_check(struct overlay_changeset *ovcs)
 {
@@ -630,7 +630,7 @@ static int changeset_dup_entry_check(struct overlay_changeset *ovcs)
  * any portions of the changeset that were successfully created will remain
  * in @ovcs->cset.
  *
- * Returns 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
+ * Return: 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
  * invalid overlay in @ovcs->fragments[].
  */
 static int build_changeset(struct overlay_changeset *ovcs)
@@ -726,7 +726,7 @@ static struct device_node *find_target(struct device_node *info_node)
  * the top level of @tree.  The relevant top level nodes are the fragment
  * nodes and the __symbols__ node.  Any other top level node will be ignored.
  *
- * Returns 0 on success, -ENOMEM if memory allocation failure, -EINVAL if error
+ * Return: 0 on success, -ENOMEM if memory allocation failure, -EINVAL if error
  * detected in @tree, or -ENOSPC if idr_alloc() error.
  */
 static int init_overlay_changeset(struct overlay_changeset *ovcs,
@@ -1181,7 +1181,7 @@ static int overlay_removal_is_ok(struct overlay_changeset *remove_ovcs)
  * If an error is returned by an overlay changeset post-remove notifier
  * then no further overlay changeset post-remove notifier will be called.
  *
- * Returns 0 on success, or a negative error number.  *ovcs_id is set to
+ * Return: 0 on success, or a negative error number.  *ovcs_id is set to
  * zero after reverting the changeset, even if a subsequent error occurs.
  */
 int of_overlay_remove(int *ovcs_id)
@@ -1259,7 +1259,7 @@ EXPORT_SYMBOL_GPL(of_overlay_remove);
  *
  * Removes all overlays from the system in the correct order.
  *
- * Returns 0 on success, or a negative error number
+ * Return: 0 on success, or a negative error number
  */
 int of_overlay_remove_all(void)
 {
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 0ed46d301431..25d448f5af91 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -44,7 +44,7 @@ static const struct of_device_id of_skipped_node_table[] = {
  * Takes a reference to the embedded struct device which needs to be dropped
  * after use.
  *
- * Returns platform_device pointer, or NULL if not found
+ * Return: platform_device pointer, or NULL if not found
  */
 struct platform_device *of_find_device_by_node(struct device_node *np)
 {
@@ -160,7 +160,7 @@ EXPORT_SYMBOL(of_device_alloc);
  * @platform_data: pointer to populate platform_data pointer with
  * @parent: Linux device model parent device.
  *
- * Returns pointer to created platform device, or NULL if a device was not
+ * Return: Pointer to created platform device, or NULL if a device was not
  * registered.  Unavailable devices will not get registered.
  */
 static struct platform_device *of_platform_device_create_pdata(
@@ -204,7 +204,7 @@ static struct platform_device *of_platform_device_create_pdata(
  * @bus_id: name to assign device
  * @parent: Linux device model parent device.
  *
- * Returns pointer to created platform device, or NULL if a device was not
+ * Return: Pointer to created platform device, or NULL if a device was not
  * registered.  Unavailable devices will not get registered.
  */
 struct platform_device *of_platform_device_create(struct device_node *np,
@@ -463,7 +463,7 @@ EXPORT_SYMBOL(of_platform_bus_probe);
  * New board support should be using this function instead of
  * of_platform_bus_probe().
  *
- * Returns 0 on success, < 0 on failure.
+ * Return: 0 on success, < 0 on failure.
  */
 int of_platform_populate(struct device_node *root,
 			const struct of_device_id *matches,
@@ -607,7 +607,7 @@ static void devm_of_platform_populate_release(struct device *dev, void *res)
  * Similar to of_platform_populate(), but will automatically call
  * of_platform_depopulate() when the device is unbound from the bus.
  *
- * Returns 0 on success, < 0 on failure.
+ * Return: 0 on success, < 0 on failure.
  */
 int devm_of_platform_populate(struct device *dev)
 {
diff --git a/drivers/of/property.c b/drivers/of/property.c
index c000ed01db01..2046ae311322 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -61,9 +61,11 @@ EXPORT_SYMBOL(of_graph_is_present);
  * @elem_size:	size of the individual element
  *
  * Search for a property in a device node and count the number of elements of
- * size elem_size in it. Returns number of elements on sucess, -EINVAL if the
- * property does not exist or its length does not match a multiple of elem_size
- * and -ENODATA if the property does not have a value.
+ * size elem_size in it.
+ *
+ * Return: The number of elements on sucess, -EINVAL if the property does not
+ * exist or its length does not match a multiple of elem_size and -ENODATA if
+ * the property does not have a value.
  */
 int of_property_count_elems_of_size(const struct device_node *np,
 				const char *propname, int elem_size)
@@ -95,8 +97,9 @@ EXPORT_SYMBOL_GPL(of_property_count_elems_of_size);
  * @len:	if !=NULL, actual length is written to here
  *
  * Search for a property in a device node and valid the requested size.
- * Returns the property value on success, -EINVAL if the property does not
- *  exist, -ENODATA if property does not have a value, and -EOVERFLOW if the
+ *
+ * Return: The property value on success, -EINVAL if the property does not
+ * exist, -ENODATA if property does not have a value, and -EOVERFLOW if the
  * property data is too small or too large.
  *
  */
@@ -129,7 +132,9 @@ static void *of_find_property_value_of_size(const struct device_node *np,
  * @out_value:	pointer to return value, modified only if no error.
  *
  * Search for a property in a device node and read nth 32-bit value from
- * it. Returns 0 on success, -EINVAL if the property does not exist,
+ * it.
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist,
  * -ENODATA if property does not have a value, and -EOVERFLOW if the
  * property data isn't large enough.
  *
@@ -161,7 +166,9 @@ EXPORT_SYMBOL_GPL(of_property_read_u32_index);
  * @out_value:	pointer to return value, modified only if no error.
  *
  * Search for a property in a device node and read nth 64-bit value from
- * it. Returns 0 on success, -EINVAL if the property does not exist,
+ * it.
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist,
  * -ENODATA if property does not have a value, and -EOVERFLOW if the
  * property data isn't large enough.
  *
@@ -196,12 +203,14 @@ EXPORT_SYMBOL_GPL(of_property_read_u64_index);
  *		sz_min will be read.
  *
  * Search for a property in a device node and read 8-bit value(s) from
- * it. Returns number of elements read on success, -EINVAL if the property
- * does not exist, -ENODATA if property does not have a value, and -EOVERFLOW
- * if the property data is smaller than sz_min or longer than sz_max.
+ * it.
  *
  * dts entry of array should be like:
- *	property = /bits/ 8 <0x50 0x60 0x70>;
+ *  ``property = /bits/ 8 <0x50 0x60 0x70>;``
+ *
+ * Return: The number of elements read on success, -EINVAL if the property
+ * does not exist, -ENODATA if property does not have a value, and -EOVERFLOW
+ * if the property data is smaller than sz_min or longer than sz_max.
  *
  * The out_values is modified only if a valid u8 value can be decoded.
  */
@@ -244,12 +253,14 @@ EXPORT_SYMBOL_GPL(of_property_read_variable_u8_array);
  *		sz_min will be read.
  *
  * Search for a property in a device node and read 16-bit value(s) from
- * it. Returns number of elements read on success, -EINVAL if the property
- * does not exist, -ENODATA if property does not have a value, and -EOVERFLOW
- * if the property data is smaller than sz_min or longer than sz_max.
+ * it.
  *
  * dts entry of array should be like:
- *	property = /bits/ 16 <0x5000 0x6000 0x7000>;
+ *  ``property = /bits/ 16 <0x5000 0x6000 0x7000>;``
+ *
+ * Return: The number of elements read on success, -EINVAL if the property
+ * does not exist, -ENODATA if property does not have a value, and -EOVERFLOW
+ * if the property data is smaller than sz_min or longer than sz_max.
  *
  * The out_values is modified only if a valid u16 value can be decoded.
  */
@@ -292,7 +303,9 @@ EXPORT_SYMBOL_GPL(of_property_read_variable_u16_array);
  *		sz_min will be read.
  *
  * Search for a property in a device node and read 32-bit value(s) from
- * it. Returns number of elements read on success, -EINVAL if the property
+ * it.
+ *
+ * Return: The number of elements read on success, -EINVAL if the property
  * does not exist, -ENODATA if property does not have a value, and -EOVERFLOW
  * if the property data is smaller than sz_min or longer than sz_max.
  *
@@ -331,7 +344,9 @@ EXPORT_SYMBOL_GPL(of_property_read_variable_u32_array);
  * @out_value:	pointer to return value, modified only if return value is 0.
  *
  * Search for a property in a device node and read a 64-bit value from
- * it. Returns 0 on success, -EINVAL if the property does not exist,
+ * it.
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist,
  * -ENODATA if property does not have a value, and -EOVERFLOW if the
  * property data isn't large enough.
  *
@@ -366,7 +381,9 @@ EXPORT_SYMBOL_GPL(of_property_read_u64);
  *		sz_min will be read.
  *
  * Search for a property in a device node and read 64-bit value(s) from
- * it. Returns number of elements read on success, -EINVAL if the property
+ * it.
+ *
+ * Return: The number of elements read on success, -EINVAL if the property
  * does not exist, -ENODATA if property does not have a value, and -EOVERFLOW
  * if the property data is smaller than sz_min or longer than sz_max.
  *
@@ -408,10 +425,11 @@ EXPORT_SYMBOL_GPL(of_property_read_variable_u64_array);
  *		return value is 0.
  *
  * Search for a property in a device tree node and retrieve a null
- * terminated string value (pointer to data, not a copy). Returns 0 on
- * success, -EINVAL if the property does not exist, -ENODATA if property
- * does not have a value, and -EILSEQ if the string is not null-terminated
- * within the length of the property data.
+ * terminated string value (pointer to data, not a copy).
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist, -ENODATA if
+ * property does not have a value, and -EILSEQ if the string is not
+ * null-terminated within the length of the property data.
  *
  * The out_string pointer is modified only if a valid string can be decoded.
  */
@@ -775,7 +793,7 @@ EXPORT_SYMBOL(of_graph_get_remote_port_parent);
  * @node: pointer to a local endpoint device_node
  *
  * Return: Remote port node associated with remote endpoint node linked
- *	   to @node. Use of_node_put() on it when done.
+ * to @node. Use of_node_put() on it when done.
  */
 struct device_node *of_graph_get_remote_port(const struct device_node *node)
 {
@@ -808,7 +826,7 @@ EXPORT_SYMBOL(of_graph_get_endpoint_count);
  * @endpoint: identifier (value of reg property) of the endpoint node
  *
  * Return: Remote device node associated with remote endpoint node linked
- *	   to @node. Use of_node_put() on it when done.
+ * to @node. Use of_node_put() on it when done.
  */
 struct device_node *of_graph_get_remote_node(const struct device_node *node,
 					     u32 port, u32 endpoint)
diff --git a/include/linux/of.h b/include/linux/of.h
index e9209ef44cc0..ef6b161d1f91 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -424,12 +424,14 @@ extern int of_detach_node(struct device_node *);
  * @sz:		number of array elements to read
  *
  * Search for a property in a device node and read 8-bit value(s) from
- * it. Returns 0 on success, -EINVAL if the property does not exist,
- * -ENODATA if property does not have a value, and -EOVERFLOW if the
- * property data isn't large enough.
+ * it.
  *
  * dts entry of array should be like:
- *	property = /bits/ 8 <0x50 0x60 0x70>;
+ *  ``property = /bits/ 8 <0x50 0x60 0x70>;``
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist,
+ * -ENODATA if property does not have a value, and -EOVERFLOW if the
+ * property data isn't large enough.
  *
  * The out_values is modified only if a valid u8 value can be decoded.
  */
@@ -454,12 +456,14 @@ static inline int of_property_read_u8_array(const struct device_node *np,
  * @sz:		number of array elements to read
  *
  * Search for a property in a device node and read 16-bit value(s) from
- * it. Returns 0 on success, -EINVAL if the property does not exist,
- * -ENODATA if property does not have a value, and -EOVERFLOW if the
- * property data isn't large enough.
+ * it.
  *
  * dts entry of array should be like:
- *	property = /bits/ 16 <0x5000 0x6000 0x7000>;
+ *  ``property = /bits/ 16 <0x5000 0x6000 0x7000>;``
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist,
+ * -ENODATA if property does not have a value, and -EOVERFLOW if the
+ * property data isn't large enough.
  *
  * The out_values is modified only if a valid u16 value can be decoded.
  */
@@ -485,7 +489,9 @@ static inline int of_property_read_u16_array(const struct device_node *np,
  * @sz:		number of array elements to read
  *
  * Search for a property in a device node and read 32-bit value(s) from
- * it. Returns 0 on success, -EINVAL if the property does not exist,
+ * it.
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist,
  * -ENODATA if property does not have a value, and -EOVERFLOW if the
  * property data isn't large enough.
  *
@@ -513,7 +519,9 @@ static inline int of_property_read_u32_array(const struct device_node *np,
  * @sz:		number of array elements to read
  *
  * Search for a property in a device node and read 64-bit value(s) from
- * it. Returns 0 on success, -EINVAL if the property does not exist,
+ * it.
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist,
  * -ENODATA if property does not have a value, and -EOVERFLOW if the
  * property data isn't large enough.
  *
@@ -1070,7 +1078,9 @@ static inline bool of_node_is_type(const struct device_node *np, const char *typ
  * @propname:	name of the property to be searched.
  *
  * Search for a property in a device node and count the number of u8 elements
- * in it. Returns number of elements on sucess, -EINVAL if the property does
+ * in it.
+ *
+ * Return: The number of elements on sucess, -EINVAL if the property does
  * not exist or its length does not match a multiple of u8 and -ENODATA if the
  * property does not have a value.
  */
@@ -1087,7 +1097,9 @@ static inline int of_property_count_u8_elems(const struct device_node *np,
  * @propname:	name of the property to be searched.
  *
  * Search for a property in a device node and count the number of u16 elements
- * in it. Returns number of elements on sucess, -EINVAL if the property does
+ * in it.
+ *
+ * Return: The number of elements on sucess, -EINVAL if the property does
  * not exist or its length does not match a multiple of u16 and -ENODATA if the
  * property does not have a value.
  */
@@ -1104,7 +1116,9 @@ static inline int of_property_count_u16_elems(const struct device_node *np,
  * @propname:	name of the property to be searched.
  *
  * Search for a property in a device node and count the number of u32 elements
- * in it. Returns number of elements on sucess, -EINVAL if the property does
+ * in it.
+ *
+ * Return: The number of elements on sucess, -EINVAL if the property does
  * not exist or its length does not match a multiple of u32 and -ENODATA if the
  * property does not have a value.
  */
@@ -1121,7 +1135,9 @@ static inline int of_property_count_u32_elems(const struct device_node *np,
  * @propname:	name of the property to be searched.
  *
  * Search for a property in a device node and count the number of u64 elements
- * in it. Returns number of elements on sucess, -EINVAL if the property does
+ * in it.
+ *
+ * Return: The number of elements on sucess, -EINVAL if the property does
  * not exist or its length does not match a multiple of u64 and -ENODATA if the
  * property does not have a value.
  */
@@ -1142,7 +1158,7 @@ static inline int of_property_count_u64_elems(const struct device_node *np,
  * Search for a property in a device tree node and retrieve a list of
  * terminated string values (pointer to data, not a copy) in that property.
  *
- * If @out_strs is NULL, the number of strings in the property is returned.
+ * Return: If @out_strs is NULL, the number of strings in the property is returned.
  */
 static inline int of_property_read_string_array(const struct device_node *np,
 						const char *propname, const char **out_strs,
@@ -1158,10 +1174,11 @@ static inline int of_property_read_string_array(const struct device_node *np,
  * @propname:	name of the property to be searched.
  *
  * Search for a property in a device tree node and retrieve the number of null
- * terminated string contain in it. Returns the number of strings on
- * success, -EINVAL if the property does not exist, -ENODATA if property
- * does not have a value, and -EILSEQ if the string is not null-terminated
- * within the length of the property data.
+ * terminated string contain in it.
+ *
+ * Return: The number of strings on success, -EINVAL if the property does not
+ * exist, -ENODATA if property does not have a value, and -EILSEQ if the string
+ * is not null-terminated within the length of the property data.
  */
 static inline int of_property_count_strings(const struct device_node *np,
 					    const char *propname)
@@ -1181,7 +1198,8 @@ static inline int of_property_count_strings(const struct device_node *np,
  * Search for a property in a device tree node and retrieve a null
  * terminated string value (pointer to data, not a copy) in the list of strings
  * contained in that property.
- * Returns 0 on success, -EINVAL if the property does not exist, -ENODATA if
+ *
+ * Return: 0 on success, -EINVAL if the property does not exist, -ENODATA if
  * property does not have a value, and -EILSEQ if the string is not
  * null-terminated within the length of the property data.
  *
@@ -1201,7 +1219,8 @@ static inline int of_property_read_string_index(const struct device_node *np,
  * @propname:	name of the property to be searched.
  *
  * Search for a property in a device node.
- * Returns true if the property exists false otherwise.
+ *
+ * Return: true if the property exists false otherwise.
  */
 static inline bool of_property_read_bool(const struct device_node *np,
 					 const char *propname)
@@ -1447,7 +1466,7 @@ static inline int of_reconfig_get_state_change(unsigned long action,
  * of_device_is_system_power_controller - Tells if system-power-controller is found for device_node
  * @np: Pointer to the given device_node
  *
- * return true if present false otherwise
+ * Return: true if present false otherwise
  */
 static inline bool of_device_is_system_power_controller(const struct device_node *np)
 {
-- 
2.27.0

