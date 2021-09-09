Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989074046B7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 10:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhIIIGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 04:06:02 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44870 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhIIIFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 04:05:13 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210909080353euoutp01597d43eb3b2ed295bcb149fbe1fa1a57~jGK-IaPSI0246802468euoutp01-
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 08:03:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210909080353euoutp01597d43eb3b2ed295bcb149fbe1fa1a57~jGK-IaPSI0246802468euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1631174633;
        bh=0ORrrljomJ6FOZG4YAwXicPPwD3gDq5t4cOsQN/nHmc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=KGfZaEGaYeBfsU/hCr80jXYraJn1pmWHVpqf5dWyX1DiApXJZZJiGBPtmp0SAPsm7
         k4Yp+gzJszBl/4dUAXlgAycST7kekC15WHEfSThjutaK3daVpWVDUZ+5O55/VIe8rG
         bMQe+/uYGRjnTWXtq9V+Mhlko8qbLqD7d6ZZHfBM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210909080353eucas1p109fe14fc9ed5bb54c7f505fa21b4bf65~jGK_42lTo3155631556eucas1p1d;
        Thu,  9 Sep 2021 08:03:53 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id DD.9A.56448.8EFB9316; Thu,  9
        Sep 2021 09:03:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210909080352eucas1p23850d17c78d078c0b461f9b875e9c9b6~jGK_XN4aw0316903169eucas1p2m;
        Thu,  9 Sep 2021 08:03:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210909080352eusmtrp1f1e8039603e1602bbfdac0c23453438b~jGK_WY7Hv1600416004eusmtrp1j;
        Thu,  9 Sep 2021 08:03:52 +0000 (GMT)
X-AuditID: cbfec7f5-d3bff7000002dc80-c9-6139bfe8cf9b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 18.E2.20981.8EFB9316; Thu,  9
        Sep 2021 09:03:52 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210909080351eusmtip2376e3fc2573cefae3334914a8736a757~jGK96d9Km3152731527eusmtip2H;
        Thu,  9 Sep 2021 08:03:51 +0000 (GMT)
Subject: Re: [PATCH v1] RFC: of: property: fix phy-hanlde issue
To:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     kernel-team@android.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <75889ceb-343b-161f-0280-13df347e6628@samsung.com>
Date:   Thu, 9 Sep 2021 10:03:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210908215806.2748361-1-saravanak@google.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djPc7ov9lsmGjS8N7OYf+Qcq8XMN//Z
        LHZsF7G4vGsOm0Xr3iPsFl2H/rI5sHls272N1WPnrLvsHgs2lXpsWtXJ5vF5k1wAaxSXTUpq
        TmZZapG+XQJXxr7LN9kLFutXPJ75ha2B8b9KFyMnh4SAicTJvfMYuxi5OIQEVjBK7DjXyATh
        fGGU2LBvAjOE85lRYsv0O6xdjBxgLW17FUG6hQSWM0pcmacMUfORUaK/5RgbSI2wgL3EynPm
        IDUiAqUSz24fZgSxmQXCJV7/msICYrMJGEp0ve1iA7F5BewkTh1qAKthEVCReHtkM1iNqECy
        xLS/TcwQNYISJ2c+AYtzCthIXJ35jA1iprzE9rdzmCFscYlbT+aDPSAhcIVDYsfsqawQb7pI
        PPu0B8oWlnh1fAs7hC0jcXpyDwtEQzOjxMNza9khnB5GictNMxghqqwl7pz7BfYZs4CmxPpd
        +pCAcJSYP8UXwuSTuPFWEOIGPolJ26YzQ4R5JTrahCBmqEnMOr4ObuvBC5eYJzAqzULy2Swk
        38xC8s0shLULGFlWMYqnlhbnpqcWG+ellusVJ+YWl+al6yXn525iBCac0/+Of93BuOLVR71D
        jEwcjIcYJTiYlUR4T2ywTBTiTUmsrEotyo8vKs1JLT7EKM3BoiTOu2vrmnghgfTEktTs1NSC
        1CKYLBMHp1QDk/lLpwuS368tYrp39efZj8sVgkMnhO/8r25xXZT/zsLt+xIi3h/T2rXXa37x
        KsPnUi/n7Vo9s/cvM9s5z8Od5j5nGHV966K0RQsn/nsQcG5rggvnXxbxlHNvljxKriz5fTVJ
        iudlbtm/NfM9HsYfl3nL0Ly5gu/jwinLrDPDLlw+vutu0ZpIi1N9mw2frPrR4lT4/MtnB98v
        W8tyt/2Y/6z6mYuUu8QbmztclixBjZ8lnXSFJF4GapZse5SkKtfbYCBfuHR77MJkyadhL7U6
        i78YKBdx2rApdIlrXFrnbWA/Va+kfU566d0ZC/Y/Orq9s0b8xpXVD0onRtVLBO7Vmvww7Z7a
        teh1ErmnyssqgpRYijMSDbWYi4oTAcHHa9inAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xe7ov9lsmGmxZKmEx/8g5VouZb/6z
        WezYLmJxedccNovWvUfYLboO/WVzYPPYtnsbq8fOWXfZPRZsKvXYtKqTzePzJrkA1ig9m6L8
        0pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jH2Xb7IXLNav
        eDzzC1sD43+VLkYODgkBE4m2vYpdjFwcQgJLGSX+bnnN3MXICRSXkTg5rYEVwhaW+HOtiw2i
        6D2jxKWfk9hBmoUF7CVWnjMHqRERKJXYceAnO4jNLBAusXfnBWaI+n5GiYbz/8ASbAKGEl1v
        QQZxcvAK2EmcOtTACGKzCKhIvD2ymQXEFhVIlnj7+jsTRI2gxMmZT8DinAI2EldnPmODWGAm
        MW/zQ2YIW15i+9s5ULa4xK0n85kmMArNQtI+C0nLLCQts5C0LGBkWcUoklpanJueW2ykV5yY
        W1yal66XnJ+7iREYZduO/dyyg3Hlq496hxiZOBgPMUpwMCuJ8J7YYJkoxJuSWFmVWpQfX1Sa
        k1p8iNEU6J+JzFKiyfnAOM8riTc0MzA1NDGzNDC1NDNWEuc1ObImXkggPbEkNTs1tSC1CKaP
        iYNTqoHJzYUrLDHeRPO9/YL39/bzLZxre2emrYbRlc6ZTA9TXNQbp67YO8Hk8E2Ox0E3DIS3
        Xyqdd0YmIbfU4Xfc2WUr2Ipy3Kx7lI2eJj+/u5AtWvaOredsnqic598uTPi4bEGS7T/379MO
        F7/72vRDSPvn30KjHPsXurs8ftxs29jDEVQZdn3LbM1WsePFdhbv/tVwS3zVZsp6qj7B9EoQ
        Y8XBp077Q+4HtZ3M4V1nNHXLuVsvJosc/JbTbuA/yTsk2kS1uG3ja+MHxlNjds0WnzeX149p
        bpjkic39ypyxStwfj7bv61SsOXtHabLitItT7bifHMxYksU1XfSRxvIGtjW30t/OvWT+OZ5z
        45W/c4s1lViKMxINtZiLihMB9j9OojsDAAA=
X-CMS-MailID: 20210909080352eucas1p23850d17c78d078c0b461f9b875e9c9b6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210908215815eucas1p12d139145cbb80041ca0dce750eed04fb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210908215815eucas1p12d139145cbb80041ca0dce750eed04fb
References: <CGME20210908215815eucas1p12d139145cbb80041ca0dce750eed04fb@eucas1p1.samsung.com>
        <20210908215806.2748361-1-saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 08.09.2021 23:58, Saravana Kannan wrote:
> This is a test patch. I'll split it up into multiple commits and clean
> it up once it's shown to help.
>
> Marek, can you please test this and let me know if it helps?
I've just checked and nope, it doesn't help for my case. Ethernet is 
still not probed on Amlogic G12A/B SoC based boards. :(
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>   drivers/of/property.c | 76 ++++++++++++++++++++++++-------------------
>   1 file changed, 43 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 0c0dc2e369c0..039e1cb07348 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -30,6 +30,35 @@
>   
>   #include "of_private.h"
>   
> +/**
> + * struct supplier_bindings - Property parsing functions for suppliers
> + *
> + * @parse_prop: function name
> + *	parse_prop() finds the node corresponding to a supplier phandle
> + * @parse_prop.np: Pointer to device node holding supplier phandle property
> + * @parse_prop.prop_name: Name of property holding a phandle value
> + * @parse_prop.index: For properties holding a list of phandles, this is the
> + *		      index into the list
> + * @optional: Describes whether a supplier is mandatory or not
> + * @node_not_dev: The consumer node containing the property is never a device.
> + * @sup_node_always_dev: The supplier node pointed to by the property will
> + *			 always have a struct device created for it even if it
> + *			 doesn't have a "compatible" property.
> + *
> + * Returns:
> + * parse_prop() return values are
> + * - phandle node pointer with refcount incremented. Caller must of_node_put()
> + *   on it when done.
> + * - NULL if no phandle found at index
> + */
> +struct supplier_bindings {
> +	struct device_node *(*parse_prop)(struct device_node *np,
> +					  const char *prop_name, int index);
> +	bool optional;
> +	bool node_not_dev;
> +	bool sup_node_always_dev;
> +};
> +
>   /**
>    * of_graph_is_present() - check graph's presence
>    * @node: pointer to device_node containing graph port
> @@ -1079,6 +1108,7 @@ static struct device_node *of_get_compat_node(struct device_node *np)
>    * of_link_to_phandle - Add fwnode link to supplier from supplier phandle
>    * @con_np: consumer device tree node
>    * @sup_np: supplier device tree node
> + * @s: The supplier binding used to get the supplier phandle
>    *
>    * Given a phandle to a supplier device tree node (@sup_np), this function
>    * finds the device that owns the supplier device tree node and creates a
> @@ -1093,7 +1123,8 @@ static struct device_node *of_get_compat_node(struct device_node *np)
>    * - -ENODEV if struct device will never be create for supplier
>    */
>   static int of_link_to_phandle(struct device_node *con_np,
> -			      struct device_node *sup_np)
> +			      struct device_node *sup_np,
> +			      const struct supplier_bindings *s)
>   {
>   	struct device *sup_dev;
>   	struct device_node *tmp_np = sup_np;
> @@ -1102,11 +1133,15 @@ static int of_link_to_phandle(struct device_node *con_np,
>   	 * Find the device node that contains the supplier phandle.  It may be
>   	 * @sup_np or it may be an ancestor of @sup_np.
>   	 */
> -	sup_np = of_get_compat_node(sup_np);
> -	if (!sup_np) {
> -		pr_debug("Not linking %pOFP to %pOFP - No device\n",
> -			 con_np, tmp_np);
> -		return -ENODEV;
> +	if (s->sup_node_always_dev) {
> +		of_node_get(sup_np);
> +	} else {
> +		sup_np = of_get_compat_node(sup_np);
> +		if (!sup_np) {
> +			pr_debug("Not linking %pOFP to %pOFP - No device\n",
> +				 con_np, tmp_np);
> +			return -ENODEV;
> +		}
>   	}
>   
>   	/*
> @@ -1239,31 +1274,6 @@ static struct device_node *parse_##fname(struct device_node *np,	     \
>   	return parse_suffix_prop_cells(np, prop_name, index, suffix, cells); \
>   }
>   
> -/**
> - * struct supplier_bindings - Property parsing functions for suppliers
> - *
> - * @parse_prop: function name
> - *	parse_prop() finds the node corresponding to a supplier phandle
> - * @parse_prop.np: Pointer to device node holding supplier phandle property
> - * @parse_prop.prop_name: Name of property holding a phandle value
> - * @parse_prop.index: For properties holding a list of phandles, this is the
> - *		      index into the list
> - * @optional: Describes whether a supplier is mandatory or not
> - * @node_not_dev: The consumer node containing the property is never a device.
> - *
> - * Returns:
> - * parse_prop() return values are
> - * - phandle node pointer with refcount incremented. Caller must of_node_put()
> - *   on it when done.
> - * - NULL if no phandle found at index
> - */
> -struct supplier_bindings {
> -	struct device_node *(*parse_prop)(struct device_node *np,
> -					  const char *prop_name, int index);
> -	bool optional;
> -	bool node_not_dev;
> -};
> -
>   DEFINE_SIMPLE_PROP(clocks, "clocks", "#clock-cells")
>   DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cells")
>   DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
> @@ -1380,7 +1390,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
>   	{ .parse_prop = parse_resets, },
>   	{ .parse_prop = parse_leds, },
>   	{ .parse_prop = parse_backlight, },
> -	{ .parse_prop = parse_phy_handle, },
> +	{ .parse_prop = parse_phy_handle, .sup_node_always_dev = true, },
>   	{ .parse_prop = parse_gpio_compat, },
>   	{ .parse_prop = parse_interrupts, },
>   	{ .parse_prop = parse_regulators, },
> @@ -1430,7 +1440,7 @@ static int of_link_property(struct device_node *con_np, const char *prop_name)
>   					: of_node_get(con_np);
>   			matched = true;
>   			i++;
> -			of_link_to_phandle(con_dev_np, phandle);
> +			of_link_to_phandle(con_dev_np, phandle, s);
>   			of_node_put(phandle);
>   			of_node_put(con_dev_np);
>   		}

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

