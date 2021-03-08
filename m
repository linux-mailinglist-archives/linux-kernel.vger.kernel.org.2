Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AD1330B5C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhCHKgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:36:31 -0500
Received: from mga05.intel.com ([192.55.52.43]:3862 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230509AbhCHKgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:36:21 -0500
IronPort-SDR: 4yDqy6j7gckXdQNz4bp/3o+wAk7WhJOWTWI2XNC+32krhy77CMmC0q3QYC3qy3tvpGI5fiEDEv
 65lC3n/HOE1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="273030995"
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="273030995"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 02:36:20 -0800
IronPort-SDR: F/1tHXKoUuYJoSj1vET/P39iSfcxr6gAmmaBL4uxggB7xrBpV52uG5RCHjQ1AHPTfPJtN2//s2
 6utCjr5uMptw==
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="447093347"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 02:36:18 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lJDFI-00An5y-AW; Mon, 08 Mar 2021 12:36:16 +0200
Date:   Mon, 8 Mar 2021 12:36:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/1] device property: Add test cases for
 fwnode_property_count_*() APIs
Message-ID: <YEX+INKSPAzAcvFg@smile.fi.intel.com>
References: <20210212162539.86850-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212162539.86850-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 06:25:39PM +0200, Andy Shevchenko wrote:
> Add test cases for fwnode_property_count_*() APIs.
> 
> While at it, modify the arrays of integers to be size of non-power-of-2
> for better test coverage and decreasing stack usage.

Any comments on this?

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/test/property-entry-test.c | 50 +++++++++++++++++++++++--
>  1 file changed, 46 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/test/property-entry-test.c b/drivers/base/test/property-entry-test.c
> index abe03315180f..3a4f755c483c 100644
> --- a/drivers/base/test/property-entry-test.c
> +++ b/drivers/base/test/property-entry-test.c
> @@ -27,6 +27,9 @@ static void pe_test_uints(struct kunit *test)
>  	node = fwnode_create_software_node(entries, NULL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
>  
> +	error = fwnode_property_count_u8(node, "prop-u8");
> +	KUNIT_EXPECT_EQ(test, error, 1);
> +
>  	error = fwnode_property_read_u8(node, "prop-u8", &val_u8);
>  	KUNIT_EXPECT_EQ(test, error, 0);
>  	KUNIT_EXPECT_EQ(test, (int)val_u8, 8);
> @@ -48,6 +51,9 @@ static void pe_test_uints(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, error, 0);
>  	KUNIT_EXPECT_EQ(test, (int)val_u16, 16);
>  
> +	error = fwnode_property_count_u16(node, "prop-u16");
> +	KUNIT_EXPECT_EQ(test, error, 1);
> +
>  	error = fwnode_property_read_u16_array(node, "prop-u16", array_u16, 1);
>  	KUNIT_EXPECT_EQ(test, error, 0);
>  	KUNIT_EXPECT_EQ(test, (int)array_u16[0], 16);
> @@ -65,6 +71,9 @@ static void pe_test_uints(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, error, 0);
>  	KUNIT_EXPECT_EQ(test, (int)val_u32, 32);
>  
> +	error = fwnode_property_count_u32(node, "prop-u32");
> +	KUNIT_EXPECT_EQ(test, error, 1);
> +
>  	error = fwnode_property_read_u32_array(node, "prop-u32", array_u32, 1);
>  	KUNIT_EXPECT_EQ(test, error, 0);
>  	KUNIT_EXPECT_EQ(test, (int)array_u32[0], 32);
> @@ -82,6 +91,9 @@ static void pe_test_uints(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, error, 0);
>  	KUNIT_EXPECT_EQ(test, (int)val_u64, 64);
>  
> +	error = fwnode_property_count_u64(node, "prop-u64");
> +	KUNIT_EXPECT_EQ(test, error, 1);
> +
>  	error = fwnode_property_read_u64_array(node, "prop-u64", array_u64, 1);
>  	KUNIT_EXPECT_EQ(test, error, 0);
>  	KUNIT_EXPECT_EQ(test, (int)array_u64[0], 64);
> @@ -95,15 +107,19 @@ static void pe_test_uints(struct kunit *test)
>  	error = fwnode_property_read_u64_array(node, "no-prop-u64", array_u64, 1);
>  	KUNIT_EXPECT_NE(test, error, 0);
>  
> +	/* Count 64-bit values as 16-bit */
> +	error = fwnode_property_count_u16(node, "prop-u64");
> +	KUNIT_EXPECT_EQ(test, error, 4);
> +
>  	fwnode_remove_software_node(node);
>  }
>  
>  static void pe_test_uint_arrays(struct kunit *test)
>  {
> -	static const u8 a_u8[16] = { 8, 9 };
> -	static const u16 a_u16[16] = { 16, 17 };
> -	static const u32 a_u32[16] = { 32, 33 };
> -	static const u64 a_u64[16] = { 64, 65 };
> +	static const u8 a_u8[10] = { 8, 9 };
> +	static const u16 a_u16[10] = { 16, 17 };
> +	static const u32 a_u32[10] = { 32, 33 };
> +	static const u64 a_u64[10] = { 64, 65 };
>  	static const struct property_entry entries[] = {
>  		PROPERTY_ENTRY_U8_ARRAY("prop-u8", a_u8),
>  		PROPERTY_ENTRY_U16_ARRAY("prop-u16", a_u16),
> @@ -126,6 +142,9 @@ static void pe_test_uint_arrays(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, error, 0);
>  	KUNIT_EXPECT_EQ(test, (int)val_u8, 8);
>  
> +	error = fwnode_property_count_u8(node, "prop-u8");
> +	KUNIT_EXPECT_EQ(test, error, 10);
> +
>  	error = fwnode_property_read_u8_array(node, "prop-u8", array_u8, 1);
>  	KUNIT_EXPECT_EQ(test, error, 0);
>  	KUNIT_EXPECT_EQ(test, (int)array_u8[0], 8);
> @@ -148,6 +167,9 @@ static void pe_test_uint_arrays(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, error, 0);
>  	KUNIT_EXPECT_EQ(test, (int)val_u16, 16);
>  
> +	error = fwnode_property_count_u16(node, "prop-u16");
> +	KUNIT_EXPECT_EQ(test, error, 10);
> +
>  	error = fwnode_property_read_u16_array(node, "prop-u16", array_u16, 1);
>  	KUNIT_EXPECT_EQ(test, error, 0);
>  	KUNIT_EXPECT_EQ(test, (int)array_u16[0], 16);
> @@ -170,6 +192,9 @@ static void pe_test_uint_arrays(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, error, 0);
>  	KUNIT_EXPECT_EQ(test, (int)val_u32, 32);
>  
> +	error = fwnode_property_count_u32(node, "prop-u32");
> +	KUNIT_EXPECT_EQ(test, error, 10);
> +
>  	error = fwnode_property_read_u32_array(node, "prop-u32", array_u32, 1);
>  	KUNIT_EXPECT_EQ(test, error, 0);
>  	KUNIT_EXPECT_EQ(test, (int)array_u32[0], 32);
> @@ -192,6 +217,9 @@ static void pe_test_uint_arrays(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, error, 0);
>  	KUNIT_EXPECT_EQ(test, (int)val_u64, 64);
>  
> +	error = fwnode_property_count_u64(node, "prop-u64");
> +	KUNIT_EXPECT_EQ(test, error, 10);
> +
>  	error = fwnode_property_read_u64_array(node, "prop-u64", array_u64, 1);
>  	KUNIT_EXPECT_EQ(test, error, 0);
>  	KUNIT_EXPECT_EQ(test, (int)array_u64[0], 64);
> @@ -210,6 +238,14 @@ static void pe_test_uint_arrays(struct kunit *test)
>  	error = fwnode_property_read_u64_array(node, "no-prop-u64", array_u64, 1);
>  	KUNIT_EXPECT_NE(test, error, 0);
>  
> +	/* Count 64-bit values as 16-bit */
> +	error = fwnode_property_count_u16(node, "prop-u64");
> +	KUNIT_EXPECT_EQ(test, error, 40);
> +
> +	/* Other way around */
> +	error = fwnode_property_count_u64(node, "prop-u16");
> +	KUNIT_EXPECT_EQ(test, error, 2);
> +
>  	fwnode_remove_software_node(node);
>  }
>  
> @@ -239,6 +275,9 @@ static void pe_test_strings(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, error, 0);
>  	KUNIT_EXPECT_STREQ(test, str, "single");
>  
> +	error = fwnode_property_string_array_count(node, "str");
> +	KUNIT_EXPECT_EQ(test, error, 1);
> +
>  	error = fwnode_property_read_string_array(node, "str", strs, 1);
>  	KUNIT_EXPECT_EQ(test, error, 1);
>  	KUNIT_EXPECT_STREQ(test, strs[0], "single");
> @@ -258,6 +297,9 @@ static void pe_test_strings(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, error, 0);
>  	KUNIT_EXPECT_STREQ(test, str, "");
>  
> +	error = fwnode_property_string_array_count(node, "strs");
> +	KUNIT_EXPECT_EQ(test, error, 2);
> +
>  	error = fwnode_property_read_string_array(node, "strs", strs, 3);
>  	KUNIT_EXPECT_EQ(test, error, 2);
>  	KUNIT_EXPECT_STREQ(test, strs[0], "string-a");
> -- 
> 2.30.0
> 

-- 
With Best Regards,
Andy Shevchenko


