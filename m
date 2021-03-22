Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC9E343ECC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhCVLDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhCVLCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:02:55 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25220C061574;
        Mon, 22 Mar 2021 04:02:54 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x21so18743560eds.4;
        Mon, 22 Mar 2021 04:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=rn+4zXp8k+v1kOYEDeZIw1a495X4bZmAUx7vNTbAlGM=;
        b=rSpCXPhEr8x4lIlJrqDkprRWJnzBpI2PMU2yHmmUJb82VSfsUSXzA8akPPAj2OpHCB
         4zQDtVFYe90aPu0uMRb6LO5+YEAyoooHEB1FUVRcxsWCiP89jGUlOVociuMRsHb+omNu
         9MLIs5KkaVoFJtY/bcmiZygMG+vuPHjPGdRjBmzE1CmHB4npxn5mXShRz4FIsUxuypQ0
         XOsx/QptYo0fb1OQX6rsE9P9YGgmoJddZKltXzXX2N2SfkzsuHiaYCyrXy3h00atc01W
         NjBKd6hfWplpTDAgjZLBLna/YTUkomoZkopIfwGIYQ+QUhLTWlTn6HR97QPUXulJOqDQ
         thig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=rn+4zXp8k+v1kOYEDeZIw1a495X4bZmAUx7vNTbAlGM=;
        b=UQB3K8YIt+hkpJXiq3xxEKHQhBWcJxCQQi3uCb7rtIfMldtiUV/c70driGA+MS3wPL
         5lfp3bHLt5P24VgLuoXptGbnuvlO9SmZR9xyag9P5Z1k78uFKf9eMdu7wR+m06M4lAgZ
         q+NnPHXUlOrhUUK8lNojzua3dBreeR4QjkKLmiCXI2ru0nV56iXzyyJkw92H/K49Tt0Q
         Bta+t2MVvCN/ATdgTHsGlwBwN+SC0i5qNKfyF7Rw8UuK2Sq62wFTe2IqFKFYx9uObfX/
         j5BXT2XdDFszxXVcRzgZwpwCzg5gBRiPRnhcsVoMyeFsf7nSh1V/kyKHmLcARjD/zIui
         Z6DQ==
X-Gm-Message-State: AOAM5336veixlo7f2vPrpyvYAhNQgyL+mpYzySp4258Nmfy141Q+yKCN
        Zuv0Zo3URF9z+d+axwrD/QU=
X-Google-Smtp-Source: ABdhPJx7tl+095jWjPi2nndIzQLVZPFPUGhfpfSmkjKcA1Bki4xVIdDo3wwh/WT2vui9tWZ/oEWocw==
X-Received: by 2002:a05:6402:5252:: with SMTP id t18mr25586178edd.258.1616410972952;
        Mon, 22 Mar 2021 04:02:52 -0700 (PDT)
Received: from [93.173.65.134] (93-173-65-134.bb.netvision.net.il. [93.173.65.134])
        by smtp.gmail.com with ESMTPSA id 90sm11797082edr.69.2021.03.22.04.02.51
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 22 Mar 2021 04:02:52 -0700 (PDT)
Message-ID: <6058792C.90801@gmail.com>
Date:   Mon, 22 Mar 2021 13:02:04 +0200
From:   Eli Billauer <eli.billauer@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     arnd@arndb.de, devel@driverdev.osuosl.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH v4 1/2] char: xillybus: Move class-related functions to
 new xillybus_class.c
References: <20210311095033.20956-1-eli.billauer@gmail.com> <20210311095033.20956-2-eli.billauer@gmail.com> <YFc65bvAN3/ZNsww@kroah.com>
In-Reply-To: <YFc65bvAN3/ZNsww@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/21 14:24, Greg KH wrote:
>> +config XILLYBUS_CLASS
>> >  +	tristate
>> >  +
>> >    config XILLYBUS
>> >    	tristate "Xillybus generic FPGA interface"
>> >    	depends on PCI || OF
>> >    	select CRC32
>> >  +	select XILLYBUS_CLASS
>>      
> depends on, do not select.
>
>    
XILLYBUS and XILLYBUS_PCIE are currently enabled as M in several Linux 
distributions. Making them depend on, rather than select XILLYBUS_CLASS 
is likely to disable the driver in those distributions.

With "select", "make oldconfig" sets XILLYBUS_CLASS to the correct value 
smoothly and silently.

Besides, isn't this the intended use case for "select"? A config symbol 
that doesn't depend on anything else, and solves a technical need to 
compile Y if X is enabled?

Or is there a way to use "depends on" without this problem?

Regards,
    Eli

