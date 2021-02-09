Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F14314CF0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhBIK0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:26:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40386 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231621AbhBIKOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:14:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612865573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CqIJM5Rb0pDVLl4xBT+85wYLCQiY/CFLwDYdnHGpbm4=;
        b=h582N2mweAasXoa8DCf2Aso5IMDqFZek+fL8TpC/6HV6YBfa1Z31XBZtxhTS+KWozRu4xH
        0SOAdC8sSIYmL/k/tNraU24lJZtAVyRaxmFIFsgs9BiiNJ70azJFekkTkj0tj1UZkJ1RUi
        BxgNhUdlmRCDkW/YNTbiJGhfTXK9/8s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-NgsICwYwMRynUQax71wkkA-1; Tue, 09 Feb 2021 05:12:48 -0500
X-MC-Unique: NgsICwYwMRynUQax71wkkA-1
Received: by mail-ej1-f69.google.com with SMTP id yd11so14830863ejb.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 02:12:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CqIJM5Rb0pDVLl4xBT+85wYLCQiY/CFLwDYdnHGpbm4=;
        b=bXYTx5gz0FlrRqvIGBUM7Cy0J/ZI7yg2yDv+Jh2XuapdVFYO74L6+c8tdEMPVCxY6n
         2jCi03UqT4pvt4IgQtC2uyRR9i8YxfnHOAprC3I4h7gfeYLZWN/SAOJsEQ+XNVj0JSOW
         Tv4A22ZUFIQtjiMcbIuLFsYtmt3BoIwrmR/brNYfKlVLo+bGMG19isx0uU5YW8mFO+Q+
         aMvmT62khc8FKSdhltmWKeIHcK3J3jjwdHrJQn7UMxMRQ8Jh0Vgv1FdXk3zJZ6QX9/kd
         V+BklXZB06chMBg8y9SDuA7KKFjiI2/TlGRIqxfarT88i2ureKo1mVStQ2PIdZBaeUfz
         VAmg==
X-Gm-Message-State: AOAM531nl9snXObmWQq8is/kPVL9m69pQmci83h6tlcQOcGogRwJBj/P
        rMEIW9Ye3xD3LMjDpiuhualH8HUCz513sqz35CL+EtLaXmlWzIU2yv3jRtOnnIlFqX07v8UYdnN
        kHti5nlMuz0PQxl0FAAQfU/vO
X-Received: by 2002:a17:906:c0c9:: with SMTP id bn9mr21789351ejb.318.1612865566945;
        Tue, 09 Feb 2021 02:12:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxqe2PFhnJ51YJZAlsWzZ/Khb+bgZhs2ZzTVe9Ztmk7VT+v8iHLP38pyxebVKUgPlM6BPuFwg==
X-Received: by 2002:a17:906:c0c9:: with SMTP id bn9mr21789335ejb.318.1612865566773;
        Tue, 09 Feb 2021 02:12:46 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id u27sm6990920edi.79.2021.02.09.02.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 02:12:46 -0800 (PST)
Subject: Re: drivers/platform/surface/surface3-wmi.c:60:14: warning: variable
 'status' set but not used
To:     kernel test robot <lkp@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <202102090907.KNAo0OTm-lkp@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <77f7e672-34b1-2123-a2de-3f6b21a0b421@redhat.com>
Date:   Tue, 9 Feb 2021 11:12:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <202102090907.KNAo0OTm-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 2/9/21 2:52 AM, kernel test robot wrote:
> Hi Maximilian,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   61556703b610a104de324e4f061dc6cf7b218b46
> commit: f23027ca3d48b6f93c5994069fb25b73539fdf34 platform/surface: Move Surface 3 WMI driver to platform/surface
> date:   4 months ago
> config: i386-randconfig-r016-20210209 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f23027ca3d48b6f93c5994069fb25b73539fdf34
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout f23027ca3d48b6f93c5994069fb25b73539fdf34
>         # save the attached .config to linux build tree
>         make W=1 ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/platform/surface/surface3-wmi.c: In function 's3_wmi_query_block':
>>> drivers/platform/surface/surface3-wmi.c:60:14: warning: variable 'status' set but not used [-Wunused-but-set-variable]
>       60 |  acpi_status status;
>          |              ^~~~~~


There is a fix for this in pdx86/for-next, so this will be fixed in 5.12 .

Regards,

Hans



> 
> 
> vim +/status +60 drivers/platform/surface/surface3-wmi.c
> 
> 3dda3b3798f96d drivers/platform/x86/surface3-wmi.c Benjamin Tissoires 2016-11-25  56  
> 3dda3b3798f96d drivers/platform/x86/surface3-wmi.c Benjamin Tissoires 2016-11-25  57  static int s3_wmi_query_block(const char *guid, int instance, int *ret)
> 3dda3b3798f96d drivers/platform/x86/surface3-wmi.c Benjamin Tissoires 2016-11-25  58  {
> 83da6b59919a71 drivers/platform/x86/surface3-wmi.c Andy Shevchenko    2016-12-15  59  	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
> 3dda3b3798f96d drivers/platform/x86/surface3-wmi.c Benjamin Tissoires 2016-11-25 @60  	acpi_status status;
> 3dda3b3798f96d drivers/platform/x86/surface3-wmi.c Benjamin Tissoires 2016-11-25  61  	union acpi_object *obj;
> 83da6b59919a71 drivers/platform/x86/surface3-wmi.c Andy Shevchenko    2016-12-15  62  	int error = 0;
> 3dda3b3798f96d drivers/platform/x86/surface3-wmi.c Benjamin Tissoires 2016-11-25  63  
> 3dda3b3798f96d drivers/platform/x86/surface3-wmi.c Benjamin Tissoires 2016-11-25  64  	mutex_lock(&s3_wmi_lock);
> 3dda3b3798f96d drivers/platform/x86/surface3-wmi.c Benjamin Tissoires 2016-11-25  65  	status = wmi_query_block(guid, instance, &output);
> 3dda3b3798f96d drivers/platform/x86/surface3-wmi.c Benjamin Tissoires 2016-11-25  66  
> 3dda3b3798f96d drivers/platform/x86/surface3-wmi.c Benjamin Tissoires 2016-11-25  67  	obj = output.pointer;
> 3dda3b3798f96d drivers/platform/x86/surface3-wmi.c Benjamin Tissoires 2016-11-25  68  
> 3dda3b3798f96d drivers/platform/x86/surface3-wmi.c Benjamin Tissoires 2016-11-25  69  	if (!obj || obj->type != ACPI_TYPE_INTEGER) {
> 3dda3b3798f96d drivers/platform/x86/surface3-wmi.c Benjamin Tissoires 2016-11-25  70  		if (obj) {
> 3dda3b3798f96d drivers/platform/x86/surface3-wmi.c Benjamin Tissoires 2016-11-25  71  			pr_err("query block returned object type: %d - buffer length:%d\n",
> 3dda3b3798f96d drivers/platform/x86/surface3-wmi.c Benjamin Tissoires 2016-11-25  72  			       obj->type,
> 3dda3b3798f96d drivers/platform/x86/surface3-wmi.c Benjamin Tissoires 2016-11-25  73  			       obj->type == ACPI_TYPE_BUFFER ?
> 3dda3b3798f96d drivers/platform/x86/surface3-wmi.c Benjamin Tissoires 2016-11-25  74  						obj->buffer.length : 0);
> 3dda3b3798f96d drivers/platform/x86/surface3-wmi.c Benjamin Tissoires 2016-11-25  75  		}
> 83da6b59919a71 drivers/platform/x86/surface3-wmi.c Andy Shevchenko    2016-12-15  76  		error = -EINVAL;
> 83da6b59919a71 drivers/platform/x86/surface3-wmi.c Andy Shevchenko    2016-12-15  77  		goto out_free_unlock;
> 3dda3b3798f96d drivers/platform/x86/surface3-wmi.c Benjamin Tissoires 2016-11-25  78  	}
> 3dda3b3798f96d drivers/platform/x86/surface3-wmi.c Benjamin Tissoires 2016-11-25  79  	*ret = obj->integer.value;
> 83da6b59919a71 drivers/platform/x86/surface3-wmi.c Andy Shevchenko    2016-12-15  80   out_free_unlock:
> 3dda3b3798f96d drivers/platform/x86/surface3-wmi.c Benjamin Tissoires 2016-11-25  81  	kfree(obj);
> 3dda3b3798f96d drivers/platform/x86/surface3-wmi.c Benjamin Tissoires 2016-11-25  82  	mutex_unlock(&s3_wmi_lock);
> 83da6b59919a71 drivers/platform/x86/surface3-wmi.c Andy Shevchenko    2016-12-15  83  	return error;
> 3dda3b3798f96d drivers/platform/x86/surface3-wmi.c Benjamin Tissoires 2016-11-25  84  }
> 3dda3b3798f96d drivers/platform/x86/surface3-wmi.c Benjamin Tissoires 2016-11-25  85  
> 
> :::::: The code at line 60 was first introduced by commit
> :::::: 3dda3b3798f96d2974b5f60811142d3e25547807 platform/x86: Add custom surface3 platform device for controlling LID
> 
> :::::: TO: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> :::::: CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

