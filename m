Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B25C34B21A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 23:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhCZWUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 18:20:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhCZWTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 18:19:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BB99619FF;
        Fri, 26 Mar 2021 22:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616797181;
        bh=rb2XANYYYu9LEhFUJadIJ+jQoTEzCLGvA6Jn5fs4DOk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XEHYJ6xQiPkpfLnrWLVaGpGEV2QBxksuhjVLFqFBqVIlZt+IeDQVU6VVTnXJoRv6I
         aA8kNXO6GY0qgakhE5oXwR25uTd2zwBMaxn3keVxVDb8SPK1A3nFwLz8tELT6fa7uv
         8hOgpH5/ntAVbHMCv70lWUSIWGuDDZphFL0l8XHEaW+M/vPkUGM2+MjbZ/WkoMN37q
         gUo+iiaZSZnMkqeeqSdbFmU6sgAfBGgGjNRZWur0Cc88rdmZyYNzT8khEBbmn73veF
         cLuelCOCTaMos+LEKjm8kW6qB4ja0ptKXo/g+sR8uakRNmypRKXvb1zj5bzzJAYIQq
         DHWAwQRQrqbsQ==
Date:   Fri, 26 Mar 2021 23:19:36 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v2] of: Fix kerneldoc output formatting
Message-ID: <20210326231936.08ea87d8@coco.lan>
In-Reply-To: <20210326192606.3702739-1-robh@kernel.org>
References: <20210326192606.3702739-1-robh@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 26 Mar 2021 13:26:06 -0600
Rob Herring <robh@kernel.org> escreveu:

> The indentation of the kerneldoc comments affects the output formatting.
> Leading tabs in particular don't work, sections need to be indented
> under the section header, and several code blocks are reformatted.
> 
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
> - Updated the example code blocks to use 'Example::' which depends (for 
>   nice output) on Mauro's fix.
> 
> The rest of the series is here[1].
> 
> [1] https://lore.kernel.org/r/20210325164713.1296407-1-robh@kernel.org/
> 
>  drivers/of/base.c | 275 +++++++++++++++++++++++-----------------------
>  drivers/of/fdt.c  |   9 +-
>  2 files changed, 141 insertions(+), 143 deletions(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 457d1ec27300..a64c093d30ef 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -651,11 +651,11 @@ bool of_device_is_big_endian(const struct device_node *device)
>  EXPORT_SYMBOL(of_device_is_big_endian);
>  
>  /**
> - *	of_get_parent - Get a node's parent if any
> - *	@node:	Node to get parent
> + * of_get_parent - Get a node's parent if any
> + * @node:	Node to get parent
>   *
> - *	Returns a node pointer with refcount incremented, use
> - *	of_node_put() on it when done.
> + * Return: A node pointer with refcount incremented, use
> + * of_node_put() on it when done.
>   */
>  struct device_node *of_get_parent(const struct device_node *node)
>  {
> @@ -673,15 +673,15 @@ struct device_node *of_get_parent(const struct device_node *node)
>  EXPORT_SYMBOL(of_get_parent);
>  
>  /**
> - *	of_get_next_parent - Iterate to a node's parent
> - *	@node:	Node to get parent of
> + * of_get_next_parent - Iterate to a node's parent
> + * @node:	Node to get parent of
>   *
> - *	This is like of_get_parent() except that it drops the
> - *	refcount on the passed node, making it suitable for iterating
> - *	through a node's parents.
> + * This is like of_get_parent() except that it drops the
> + * refcount on the passed node, making it suitable for iterating
> + * through a node's parents.
>   *
> - *	Returns a node pointer with refcount incremented, use
> - *	of_node_put() on it when done.
> + * Return: A node pointer with refcount incremented, use
> + * of_node_put() on it when done.
>   */
>  struct device_node *of_get_next_parent(struct device_node *node)
>  {
> @@ -719,13 +719,13 @@ static struct device_node *__of_get_next_child(const struct device_node *node,
>  	     child = __of_get_next_child(parent, child))
>  
>  /**
> - *	of_get_next_child - Iterate a node childs
> - *	@node:	parent node
> - *	@prev:	previous child of the parent node, or NULL to get first
> + * of_get_next_child - Iterate a node childs
> + * @node:	parent node
> + * @prev:	previous child of the parent node, or NULL to get first
>   *
> - *	Returns a node pointer with refcount incremented, use of_node_put() on
> - *	it when done. Returns NULL when prev is the last child. Decrements the
> - *	refcount of prev.
> + * Return: A node pointer with refcount incremented, use of_node_put() on
> + * it when done. Returns NULL when prev is the last child. Decrements the
> + * refcount of prev.
>   */
>  struct device_node *of_get_next_child(const struct device_node *node,
>  	struct device_node *prev)
> @@ -741,12 +741,12 @@ struct device_node *of_get_next_child(const struct device_node *node,
>  EXPORT_SYMBOL(of_get_next_child);
>  
>  /**
> - *	of_get_next_available_child - Find the next available child node
> - *	@node:	parent node
> - *	@prev:	previous child of the parent node, or NULL to get first
> + * of_get_next_available_child - Find the next available child node
> + * @node:	parent node
> + * @prev:	previous child of the parent node, or NULL to get first
>   *
> - *      This function is like of_get_next_child(), except that it
> - *      automatically skips any disabled nodes (i.e. status = "disabled").
> + * This function is like of_get_next_child(), except that it
> + * automatically skips any disabled nodes (i.e. status = "disabled").
>   */
>  struct device_node *of_get_next_available_child(const struct device_node *node,
>  	struct device_node *prev)
> @@ -772,12 +772,12 @@ struct device_node *of_get_next_available_child(const struct device_node *node,
>  EXPORT_SYMBOL(of_get_next_available_child);
>  
>  /**
> - *	of_get_next_cpu_node - Iterate on cpu nodes
> - *	@prev:	previous child of the /cpus node, or NULL to get first
> + * of_get_next_cpu_node - Iterate on cpu nodes
> + * @prev:	previous child of the /cpus node, or NULL to get first
>   *
> - *	Returns a cpu node pointer with refcount incremented, use of_node_put()
> - *	on it when done. Returns NULL when prev is the last child. Decrements
> - *	the refcount of prev.
> + * Return: A cpu node pointer with refcount incremented, use of_node_put()
> + * on it when done. Returns NULL when prev is the last child. Decrements
> + * the refcount of prev.
>   */
>  struct device_node *of_get_next_cpu_node(struct device_node *prev)
>  {
> @@ -834,15 +834,15 @@ struct device_node *of_get_compatible_child(const struct device_node *parent,
>  EXPORT_SYMBOL(of_get_compatible_child);
>  
>  /**
> - *	of_get_child_by_name - Find the child node by name for a given parent
> - *	@node:	parent node
> - *	@name:	child name to look for.
> + * of_get_child_by_name - Find the child node by name for a given parent
> + * @node:	parent node
> + * @name:	child name to look for.
>   *
> - *      This function looks for child node for given matching name
> + * This function looks for child node for given matching name
>   *
> - *	Returns a node pointer if found, with refcount incremented, use
> - *	of_node_put() on it when done.
> - *	Returns NULL if node is not found.
> + * Return: A node pointer if found, with refcount incremented, use
> + * of_node_put() on it when done.
> + * Returns NULL if node is not found.
>   */
>  struct device_node *of_get_child_by_name(const struct device_node *node,
>  				const char *name)
> @@ -893,22 +893,22 @@ struct device_node *__of_find_node_by_full_path(struct device_node *node,
>  }
>  
>  /**
> - *	of_find_node_opts_by_path - Find a node matching a full OF path
> - *	@path: Either the full path to match, or if the path does not
> - *	       start with '/', the name of a property of the /aliases
> - *	       node (an alias).  In the case of an alias, the node
> - *	       matching the alias' value will be returned.
> - *	@opts: Address of a pointer into which to store the start of
> - *	       an options string appended to the end of the path with
> - *	       a ':' separator.
> - *
> - *	Valid paths:
> - *		/foo/bar	Full path
> - *		foo		Valid alias
> - *		foo/bar		Valid alias + relative path
> - *
> - *	Returns a node pointer with refcount incremented, use
> - *	of_node_put() on it when done.
> + * of_find_node_opts_by_path - Find a node matching a full OF path
> + * @path: Either the full path to match, or if the path does not
> + *       start with '/', the name of a property of the /aliases
> + *       node (an alias).  In the case of an alias, the node
> + *       matching the alias' value will be returned.
> + * @opts: Address of a pointer into which to store the start of
> + *       an options string appended to the end of the path with
> + *       a ':' separator.
> + *
> + * Valid paths:
> + *  * /foo/bar	Full path
> + *  * foo	Valid alias
> + *  * foo/bar	Valid alias + relative path
> + *
> + * Return: A node pointer with refcount incremented, use
> + * of_node_put() on it when done.
>   */
>  struct device_node *of_find_node_opts_by_path(const char *path, const char **opts)
>  {
> @@ -958,15 +958,15 @@ struct device_node *of_find_node_opts_by_path(const char *path, const char **opt
>  EXPORT_SYMBOL(of_find_node_opts_by_path);
>  
>  /**
> - *	of_find_node_by_name - Find a node by its "name" property
> - *	@from:	The node to start searching from or NULL; the node
> + * of_find_node_by_name - Find a node by its "name" property
> + * @from:	The node to start searching from or NULL; the node
>   *		you pass will not be searched, only the next one
>   *		will. Typically, you pass what the previous call
>   *		returned. of_node_put() will be called on @from.
> - *	@name:	The name string to match against
> + * @name:	The name string to match against
>   *
> - *	Returns a node pointer with refcount incremented, use
> - *	of_node_put() on it when done.
> + * Return: A node pointer with refcount incremented, use
> + * of_node_put() on it when done.
>   */
>  struct device_node *of_find_node_by_name(struct device_node *from,
>  	const char *name)
> @@ -985,16 +985,16 @@ struct device_node *of_find_node_by_name(struct device_node *from,
>  EXPORT_SYMBOL(of_find_node_by_name);
>  
>  /**
> - *	of_find_node_by_type - Find a node by its "device_type" property
> - *	@from:	The node to start searching from, or NULL to start searching
> + * of_find_node_by_type - Find a node by its "device_type" property
> + * @from:	The node to start searching from, or NULL to start searching
>   *		the entire device tree. The node you pass will not be
>   *		searched, only the next one will; typically, you pass
>   *		what the previous call returned. of_node_put() will be
>   *		called on from for you.
> - *	@type:	The type string to match against
> + * @type:	The type string to match against
>   *
> - *	Returns a node pointer with refcount incremented, use
> - *	of_node_put() on it when done.
> + * Return: A node pointer with refcount incremented, use
> + * of_node_put() on it when done.
>   */
>  struct device_node *of_find_node_by_type(struct device_node *from,
>  	const char *type)
> @@ -1013,18 +1013,18 @@ struct device_node *of_find_node_by_type(struct device_node *from,
>  EXPORT_SYMBOL(of_find_node_by_type);
>  
>  /**
> - *	of_find_compatible_node - Find a node based on type and one of the
> + * of_find_compatible_node - Find a node based on type and one of the
>   *                                tokens in its "compatible" property
> - *	@from:		The node to start searching from or NULL, the node
> - *			you pass will not be searched, only the next one
> - *			will; typically, you pass what the previous call
> - *			returned. of_node_put() will be called on it
> - *	@type:		The type string to match "device_type" or NULL to ignore
> - *	@compatible:	The string to match to one of the tokens in the device
> - *			"compatible" list.
> - *
> - *	Returns a node pointer with refcount incremented, use
> - *	of_node_put() on it when done.
> + * @from:	The node to start searching from or NULL, the node
> + *		you pass will not be searched, only the next one
> + *		will; typically, you pass what the previous call
> + *		returned. of_node_put() will be called on it
> + * @type:	The type string to match "device_type" or NULL to ignore
> + * @compatible:	The string to match to one of the tokens in the device
> + *		"compatible" list.
> + *
> + * Return: A node pointer with refcount incremented, use
> + * of_node_put() on it when done.
>   */
>  struct device_node *of_find_compatible_node(struct device_node *from,
>  	const char *type, const char *compatible)
> @@ -1044,16 +1044,16 @@ struct device_node *of_find_compatible_node(struct device_node *from,
>  EXPORT_SYMBOL(of_find_compatible_node);
>  
>  /**
> - *	of_find_node_with_property - Find a node which has a property with
> - *                                   the given name.
> - *	@from:		The node to start searching from or NULL, the node
> - *			you pass will not be searched, only the next one
> - *			will; typically, you pass what the previous call
> - *			returned. of_node_put() will be called on it
> - *	@prop_name:	The name of the property to look for.
> - *
> - *	Returns a node pointer with refcount incremented, use
> - *	of_node_put() on it when done.
> + * of_find_node_with_property - Find a node which has a property with
> + *                              the given name.
> + * @from:	The node to start searching from or NULL, the node
> + *		you pass will not be searched, only the next one
> + *		will; typically, you pass what the previous call
> + *		returned. of_node_put() will be called on it
> + * @prop_name:	The name of the property to look for.
> + *
> + * Return: A node pointer with refcount incremented, use
> + * of_node_put() on it when done.
>   */
>  struct device_node *of_find_node_with_property(struct device_node *from,
>  	const char *prop_name)
> @@ -1102,10 +1102,10 @@ const struct of_device_id *__of_match_node(const struct of_device_id *matches,
>  
>  /**
>   * of_match_node - Tell if a device_node has a matching of_match structure
> - *	@matches:	array of of device match structures to search in
> - *	@node:		the of device structure to match against
> + * @matches:	array of of device match structures to search in
> + * @node:	the of device structure to match against
>   *
> - *	Low level utility function used by device matching.
> + * Low level utility function used by device matching.
>   */
>  const struct of_device_id *of_match_node(const struct of_device_id *matches,
>  					 const struct device_node *node)
> @@ -1121,17 +1121,17 @@ const struct of_device_id *of_match_node(const struct of_device_id *matches,
>  EXPORT_SYMBOL(of_match_node);
>  
>  /**
> - *	of_find_matching_node_and_match - Find a node based on an of_device_id
> - *					  match table.
> - *	@from:		The node to start searching from or NULL, the node
> - *			you pass will not be searched, only the next one
> - *			will; typically, you pass what the previous call
> - *			returned. of_node_put() will be called on it
> - *	@matches:	array of of device match structures to search in
> - *	@match:		Updated to point at the matches entry which matched
> - *
> - *	Returns a node pointer with refcount incremented, use
> - *	of_node_put() on it when done.
> + * of_find_matching_node_and_match - Find a node based on an of_device_id
> + *				     match table.
> + * @from:	The node to start searching from or NULL, the node
> + *		you pass will not be searched, only the next one
> + *		will; typically, you pass what the previous call
> + *		returned. of_node_put() will be called on it
> + * @matches:	array of of device match structures to search in
> + * @match:	Updated to point at the matches entry which matched
> + *
> + * Return: A node pointer with refcount incremented, use
> + * of_node_put() on it when done.
>   */
>  struct device_node *of_find_matching_node_and_match(struct device_node *from,
>  					const struct of_device_id *matches,
> @@ -1460,21 +1460,21 @@ EXPORT_SYMBOL(of_parse_phandle);
>   * Caller is responsible to call of_node_put() on the returned out_args->np
>   * pointer.
>   *
> - * Example:
> + * Example::
>   *
> - * phandle1: node1 {
> + *  phandle1: node1 {
>   *	#list-cells = <2>;
> - * }
> + *  };
>   *
> - * phandle2: node2 {
> + *  phandle2: node2 {
>   *	#list-cells = <1>;
> - * }
> + *  };
>   *
> - * node3 {
> + *  node3 {
>   *	list = <&phandle1 1 2 &phandle2 3>;
> - * }
> + *  };
>   *
> - * To get a device_node of the `node2' node you may call this:
> + * To get a device_node of the ``node2`` node you may call this:
>   * of_parse_phandle_with_args(node3, "list", "#list-cells", 1, &args);
>   */
>  int of_parse_phandle_with_args(const struct device_node *np, const char *list_name,
> @@ -1512,29 +1512,29 @@ EXPORT_SYMBOL(of_parse_phandle_with_args);
>   * Caller is responsible to call of_node_put() on the returned out_args->np
>   * pointer.
>   *
> - * Example:
> + * Example::
>   *
> - * phandle1: node1 {
> - *	#list-cells = <2>;
> - * }
> + *  phandle1: node1 {
> + *  	#list-cells = <2>;
> + *  };
>   *
> - * phandle2: node2 {
> - *	#list-cells = <1>;
> - * }
> + *  phandle2: node2 {
> + *  	#list-cells = <1>;
> + *  };
>   *
> - * phandle3: node3 {
> - * 	#list-cells = <1>;
> - * 	list-map = <0 &phandle2 3>,
> - * 		   <1 &phandle2 2>,
> - * 		   <2 &phandle1 5 1>;
> - *	list-map-mask = <0x3>;
> - * };
> + *  phandle3: node3 {
> + *  	#list-cells = <1>;
> + *  	list-map = <0 &phandle2 3>,
> + *  		   <1 &phandle2 2>,
> + *  		   <2 &phandle1 5 1>;
> + *  	list-map-mask = <0x3>;
> + *  };
>   *
> - * node4 {
> - *	list = <&phandle1 1 2 &phandle3 0>;
> - * }
> + *  node4 {
> + *  	list = <&phandle1 1 2 &phandle3 0>;
> + *  };
>   *
> - * To get a device_node of the `node2' node you may call this:
> + * To get a device_node of the ``node2`` node you may call this:
>   * of_parse_phandle_with_args(node4, "list", "list", 1, &args);
>   */
>  int of_parse_phandle_with_args_map(const struct device_node *np,
> @@ -1694,19 +1694,19 @@ EXPORT_SYMBOL(of_parse_phandle_with_args_map);
>   * Caller is responsible to call of_node_put() on the returned out_args->np
>   * pointer.
>   *
> - * Example:
> + * Example::
>   *
> - * phandle1: node1 {
> - * }
> + *  phandle1: node1 {
> + *  };
>   *
> - * phandle2: node2 {
> - * }
> + *  phandle2: node2 {
> + *  };
>   *
> - * node3 {
> - *	list = <&phandle1 0 2 &phandle2 2 3>;
> - * }
> + *  node3 {
> + *  	list = <&phandle1 0 2 &phandle2 2 3>;
> + *  };
>   *
> - * To get a device_node of the `node2' node you may call this:
> + * To get a device_node of the ``node2`` node you may call this:
>   * of_parse_phandle_with_fixed_args(node3, "list", 2, 1, &args);
>   */
>  int of_parse_phandle_with_fixed_args(const struct device_node *np,
> @@ -1952,13 +1952,12 @@ static void of_alias_add(struct alias_prop *ap, struct device_node *np,
>  
>  /**
>   * of_alias_scan - Scan all properties of the 'aliases' node
> + * @dt_alloc:	An allocator that provides a virtual address to memory
> + *		for storing the resulting tree
>   *
>   * The function scans all the properties of the 'aliases' node and populates
>   * the global lookup table with the properties.  It returns the
>   * number of alias properties found, or an error code in case of failure.
> - *
> - * @dt_alloc:	An allocator that provides a virtual address to memory
> - *		for storing the resulting tree
>   */
>  void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
>  {
> @@ -2153,12 +2152,12 @@ bool of_console_check(struct device_node *dn, char *name, int index)
>  EXPORT_SYMBOL_GPL(of_console_check);
>  
>  /**
> - *	of_find_next_cache_node - Find a node's subsidiary cache
> - *	@np:	node of type "cpu" or "cache"
> + * of_find_next_cache_node - Find a node's subsidiary cache
> + * @np:	node of type "cpu" or "cache"
>   *
> - *	Returns a node pointer with refcount incremented, use
> - *	of_node_put() on it when done.  Caller should hold a reference
> - *	to np.
> + * Return: A node pointer with refcount incremented, use
> + * of_node_put() on it when done.  Caller should hold a reference
> + * to np.
>   */
>  struct device_node *of_find_next_cache_node(const struct device_node *np)
>  {
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 4d6d195e089a..ba53da9c3895 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -349,11 +349,6 @@ static int unflatten_dt_nodes(const void *blob,
>  
>  /**
>   * __unflatten_device_tree - create tree of device_nodes from flat blob
> - *
> - * unflattens a device-tree, creating the
> - * tree of struct device_node. It also fills the "name" and "type"
> - * pointers of the nodes so the normal device-tree walking functions
> - * can be used.
>   * @blob: The blob to expand
>   * @dad: Parent device node
>   * @mynodes: The device_node tree created by the call
> @@ -361,6 +356,10 @@ static int unflatten_dt_nodes(const void *blob,
>   * for the resulting tree
>   * @detached: if true set OF_DETACHED on @mynodes
>   *
> + * unflattens a device-tree, creating the tree of struct device_node. It also
> + * fills the "name" and "type" pointers of the nodes so the normal device-tree
> + * walking functions can be used.
> + *
>   * Returns NULL on failure or the memory chunk containing the unflattened
>   * device tree on success.
>   */



Thanks,
Mauro
