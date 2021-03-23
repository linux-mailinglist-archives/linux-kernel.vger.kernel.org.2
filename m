Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C950034577B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 06:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCWFpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 01:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhCWFpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 01:45:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1891C061574;
        Mon, 22 Mar 2021 22:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=xCCP1GGlU4atbTp8xUP0b27QE4ZGZQy9D17H8dfnMtY=; b=FSbf593d62zBGpt/UfMOnuIOFo
        kKy9dszibaIE1w/wp8fMYuZslm0/DyIp8bubIZKZOPejQeXJ97MgSYYcXxXwiq5dnkYKOxxGioqzf
        IGd4mC3w0QcXkHADUMDrGraWkRuETPbqmQl1/jxd2G4inrKpNgPjkjBDFyN9XHS17KLcOMDjVLNW9
        JV9TyCc0jr86fnRjV6amPl9+CzrBfdOVtE0LTLi0l2N3fd26UVUisuK6IYDIRIQYaZmdvr1OgQf+R
        FNbe9MfmSsys7sfZYASiRnCp8eF1by7kNJxAqQoaxgWA/pScCztZW7/mUf/880GYPEM4ZI6VdU4pG
        ExKD7DWA==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOZqW-009c0m-7G; Tue, 23 Mar 2021 05:44:55 +0000
Subject: Re: [PATCH] hwmon: (ftsteutates): Rudimentary typo fixes
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, jdelvare@suse.com,
        linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210323043438.1321903-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cf627727-a448-a679-5887-b81a814649e2@infradead.org>
Date:   Mon, 22 Mar 2021 22:44:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210323043438.1321903-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 9:34 PM, Bhaskar Chowdhury wrote:
> 
> s/Temprature/Temperature/
> s/revsion/revision/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/hwmon/ftsteutates.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/ftsteutates.c b/drivers/hwmon/ftsteutates.c
> index ef88a156efc2..ceffc76a0c51 100644
> --- a/drivers/hwmon/ftsteutates.c
> +++ b/drivers/hwmon/ftsteutates.c
> @@ -509,7 +509,7 @@ fan_alarm_store(struct device *dev, struct device_attribute *devattr,
>  /* SysFS structs							     */
>  /*****************************************************************************/
> 
> -/* Temprature sensors */
> +/* Temperature sensors */
>  static SENSOR_DEVICE_ATTR_RO(temp1_input, temp_value, 0);
>  static SENSOR_DEVICE_ATTR_RO(temp2_input, temp_value, 1);
>  static SENSOR_DEVICE_ATTR_RO(temp3_input, temp_value, 2);
> @@ -713,7 +713,7 @@ static int fts_detect(struct i2c_client *client,
>  {
>  	int val;
> 
> -	/* detection works with revsion greater or equal to 0x2b */
> +	/* detection works with revision greater or equal to 0x2b */
>  	val = i2c_smbus_read_byte_data(client, FTS_DEVICE_REVISION_REG);
>  	if (val < 0x2b)
>  		return -ENODEV;
> --


-- 
~Randy

