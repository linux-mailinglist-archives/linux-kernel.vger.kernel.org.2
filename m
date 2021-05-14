Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F119138104A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 21:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbhENTIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 15:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbhENTIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 15:08:45 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C710C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 12:07:32 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g24so347143pji.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 12:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oXxhPizKNi5C4ycrbnrV7C0cq58T1/euLe6jwkV8J18=;
        b=lc0pNM3GTuqYGseYNV8m6amseWmX/bmJCURusUYDwExyji38vhah90YVTqHaNyru6t
         3JUnuGvOhHXIt6bnusS4D1SoZFR6v5ZmnS9KnBtGc7FuTd3Trz+JVoaZgiPrzzjhind7
         t4Xyj3EPI92UuprT0V5o5ldd5Vn3CwcciS4Pt1SNhjePKIJ9iUmH6gKUSkUQ6mh/srkM
         /jGT/PJzh1SqKLmU6dlxmoT3dfQKaZM9+p/oV6SHr6QuPFuGcZ4RXusEuk0iPzE9Tuvk
         1DioV3fz9bcwBe6nDg+Ix5xHEBPCE0CAzGO2ICzFPZyXityWtxVMRP63Nladu7hF1zlp
         k0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oXxhPizKNi5C4ycrbnrV7C0cq58T1/euLe6jwkV8J18=;
        b=jBYrg6fPiYGEpArIB+Ui1LDhddTrbQC+HY0YcItw6ONliczlcL3t3JyEeCKhaqNsWI
         6zH4rIhtiz78hVVHao5kNoCzwmLOlVWXkrTcl73XYNtoMGRbfKWl0KuJ+BE/fJDn6tG6
         6gLetLBcYkHEIitWqY56hyk+3f3Kh67TZq8Il7mEUdHsA9/PbzB+mIo1R5BnKRPra28Y
         goHnc/mrlVHjG0uxocSfzSxE0+jj8kBFrldz89eVFLo9x2hZeMU1Sf9BreL49I725fJv
         Rddh2r9qCAzA605lvGQ4uhxfz+RM1q4WOAgqI+gecVMhUfqA465dT3msFRAJ7My13SDu
         BTCw==
X-Gm-Message-State: AOAM531dDdkLmpClswBrZZ4/s9bR8OiO9iMZ/l/el/YyBYw1V4g2/Y/w
        8S/KU4hkO6nu3am1CXHKMYw=
X-Google-Smtp-Source: ABdhPJxv6QbnZggLOzS4U+8rDAaF6Sebnql6R06W3DOk+R7nA2OPR+Py9KJ85FLea/y7i1yYNsVYOg==
X-Received: by 2002:a17:90b:70c:: with SMTP id s12mr10245868pjz.98.1621019252029;
        Fri, 14 May 2021 12:07:32 -0700 (PDT)
Received: from fedora ([2405:201:6008:61b4:4e16:5348:d963:c66d])
        by smtp.gmail.com with ESMTPSA id d3sm9732449pjw.35.2021.05.14.12.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 12:07:31 -0700 (PDT)
Date:   Sat, 15 May 2021 00:37:25 +0530
From:   Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
To:     Alex Elder <elder@ieee.org>
Cc:     Joe Perches <joe@perches.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        pure.logic@nexus-software.ie, johan@kernel.org, elder@kernel.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: fix gb_loopback_stats_attrs definition
Message-ID: <YJ7Kbb5U71l8ukBD@fedora>
References: <20210514133039.304760-1-chouhan.shreyansh630@gmail.com>
 <YJ582f3O9K9YD3QA@kroah.com>
 <YJ5/tqFfcjxOLsF0@fedora>
 <YJ6DrLiMsdkG5loA@kroah.com>
 <YJ6H/WsojYcN/bLO@fedora>
 <YJ6Jf+Z1ReVgDt64@kroah.com>
 <YJ6TUAowTI75h/sl@fedora>
 <YJ6XpUMliWQOS8MB@kroah.com>
 <bccbec1a0ffbf6c31b5e6a78cedd78cd64f2b8fe.camel@perches.com>
 <88d7da63-d03c-7fa3-a881-aff8e7b4a618@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88d7da63-d03c-7fa3-a881-aff8e7b4a618@ieee.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 01:53:49PM -0500, Alex Elder wrote:
> On 5/14/21 10:56 AM, Joe Perches wrote:
> > On Fri, 2021-05-14 at 17:30 +0200, Greg KH wrote:
> > > On Fri, May 14, 2021 at 08:42:16PM +0530, Shreyansh Chouhan wrote:
> > []
> > > > I didn't look at how/where was the macro called and missed a very
> > > > obvious error. Now that I have looked at it, the only way I can think of
> > > > fixing this is changing the macro to a (inline?) function. Will
> > > > that be a desirable change?
> > > 
> > > No, it can't be a function, the code is fine as-is, checkpatch is just a
> > > perl script and does not always know what needs to be done.
> > 
> > true.
> > 
> > perhaps better though to rename these declaring macros to start with declare_
> 
> I don't disagree with your suggestion, but it's not clear it
> would have prevented submission of the erroneous initial patch
> (nor future ones from people who blindly follow checkpatch.pl
> suggestions).
> 

Well if it makes any difference, I think such a name would at least make
things a little more clear. Also, adding a comment to the macro definition
might help with the problem of future erronous patches.

Regards,
Shreyansh Chouhan

> 					-Alex
> 
> PS  Lots of negatives in that sentence.
> 
> > Something like this:
> > (with miscellaneous realigning of the macros line ending continuations \)
> > ---
> >   drivers/staging/greybus/loopback.c | 72 +++++++++++++++++++-------------------
> >   1 file changed, 36 insertions(+), 36 deletions(-)
> > 
> > diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
> > index 2471448ba42a..dc399792f35f 100644
> > --- a/drivers/staging/greybus/loopback.c
> > +++ b/drivers/staging/greybus/loopback.c
> > @@ -119,18 +119,18 @@ module_param(kfifo_depth, uint, 0444);
> >   #define GB_LOOPBACK_US_WAIT_MAX				1000000
> >   /* interface sysfs attributes */
> > -#define gb_loopback_ro_attr(field)				\
> > -static ssize_t field##_show(struct device *dev,			\
> > +#define declare_gb_loopback_ro_attr(field)				\
> > +static ssize_t field##_show(struct device *dev,				\
> >   			    struct device_attribute *attr,		\
> >   			    char *buf)					\
> >   {									\
> >   	struct gb_loopback *gb = dev_get_drvdata(dev);			\
> > -	return sprintf(buf, "%u\n", gb->field);			\
> > +	return sprintf(buf, "%u\n", gb->field);				\
> >   }									\
> >   static DEVICE_ATTR_RO(field)
> > -#define gb_loopback_ro_stats_attr(name, field, type)		\
> > -static ssize_t name##_##field##_show(struct device *dev,	\
> > +#define declare_gb_loopback_ro_stats_attr(name, field, type)		\
> > +static ssize_t name##_##field##_show(struct device *dev,		\
> >   			    struct device_attribute *attr,		\
> >   			    char *buf)					\
> >   {									\
> > @@ -142,8 +142,8 @@ static ssize_t name##_##field##_show(struct device *dev,	\
> >   }									\
> >   static DEVICE_ATTR_RO(name##_##field)
> > -#define gb_loopback_ro_avg_attr(name)			\
> > -static ssize_t name##_avg_show(struct device *dev,		\
> > +#define declare_gb_loopback_ro_avg_attr(name)				\
> > +static ssize_t name##_avg_show(struct device *dev,			\
> >   			    struct device_attribute *attr,		\
> >   			    char *buf)					\
> >   {									\
> > @@ -151,8 +151,8 @@ static ssize_t name##_avg_show(struct device *dev,		\
> >   	struct gb_loopback *gb;						\
> >   	u64 avg, rem;							\
> >   	u32 count;							\
> > -	gb = dev_get_drvdata(dev);			\
> > -	stats = &gb->name;					\
> > +	gb = dev_get_drvdata(dev);					\
> > +	stats = &gb->name;						\
> >   	count = stats->count ? stats->count : 1;			\
> >   	avg = stats->sum + count / 2000000; /* round closest */		\
> >   	rem = do_div(avg, count);					\
> > @@ -162,12 +162,12 @@ static ssize_t name##_avg_show(struct device *dev,		\
> >   }									\
> >   static DEVICE_ATTR_RO(name##_avg)
> > -#define gb_loopback_stats_attrs(field)				\
> > -	gb_loopback_ro_stats_attr(field, min, u);		\
> > -	gb_loopback_ro_stats_attr(field, max, u);		\
> > -	gb_loopback_ro_avg_attr(field)
> > +#define declare_gb_loopback_stats_attrs(field)				\
> > +	declare_gb_loopback_ro_stats_attr(field, min, u);		\
> > +	declare_gb_loopback_ro_stats_attr(field, max, u);		\
> > +	declare_gb_loopback_ro_avg_attr(field)
> > -#define gb_loopback_attr(field, type)					\
> > +#define declare_gb_loopback_attr(field, type)				\
> >   static ssize_t field##_show(struct device *dev,				\
> >   			    struct device_attribute *attr,		\
> >   			    char *buf)					\
> > @@ -193,8 +193,8 @@ static ssize_t field##_store(struct device *dev,			\
> >   }									\
> >   static DEVICE_ATTR_RW(field)
> > -#define gb_dev_loopback_ro_attr(field, conn)				\
> > -static ssize_t field##_show(struct device *dev,		\
> > +#define declare_gb_dev_loopback_ro_attr(field, conn)			\
> > +static ssize_t field##_show(struct device *dev,				\
> >   			    struct device_attribute *attr,		\
> >   			    char *buf)					\
> >   {									\
> > @@ -203,7 +203,7 @@ static ssize_t field##_show(struct device *dev,		\
> >   }									\
> >   static DEVICE_ATTR_RO(field)
> > -#define gb_dev_loopback_rw_attr(field, type)				\
> > +#define declare_gb_dev_loopback_rw_attr(field, type)			\
> >   static ssize_t field##_show(struct device *dev,				\
> >   			    struct device_attribute *attr,		\
> >   			    char *buf)					\
> > @@ -223,7 +223,7 @@ static ssize_t field##_store(struct device *dev,			\
> >   	if (ret != 1)							\
> >   		len = -EINVAL;						\
> >   	else								\
> > -		gb_loopback_check_attr(gb);		\
> > +		gb_loopback_check_attr(gb);				\
> >   	mutex_unlock(&gb->mutex);					\
> >   	return len;							\
> >   }									\
> > @@ -268,26 +268,26 @@ static void gb_loopback_check_attr(struct gb_loopback *gb)
> >   }
> >   /* Time to send and receive one message */
> > -gb_loopback_stats_attrs(latency);
> > +declare_gb_loopback_stats_attrs(latency);
> >   /* Number of requests sent per second on this cport */
> > -gb_loopback_stats_attrs(requests_per_second);
> > +declare_gb_loopback_stats_attrs(requests_per_second);
> >   /* Quantity of data sent and received on this cport */
> > -gb_loopback_stats_attrs(throughput);
> > +declare_gb_loopback_stats_attrs(throughput);
> >   /* Latency across the UniPro link from APBridge's perspective */
> > -gb_loopback_stats_attrs(apbridge_unipro_latency);
> > +declare_gb_loopback_stats_attrs(apbridge_unipro_latency);
> >   /* Firmware induced overhead in the GPBridge */
> > -gb_loopback_stats_attrs(gbphy_firmware_latency);
> > +declare_gb_loopback_stats_attrs(gbphy_firmware_latency);
> >   /* Number of errors encountered during loop */
> > -gb_loopback_ro_attr(error);
> > +declare_gb_loopback_ro_attr(error);
> >   /* Number of requests successfully completed async */
> > -gb_loopback_ro_attr(requests_completed);
> > +declare_gb_loopback_ro_attr(requests_completed);
> >   /* Number of requests timed out async */
> > -gb_loopback_ro_attr(requests_timedout);
> > +declare_gb_loopback_ro_attr(requests_timedout);
> >   /* Timeout minimum in useconds */
> > -gb_loopback_ro_attr(timeout_min);
> > +declare_gb_loopback_ro_attr(timeout_min);
> >   /* Timeout minimum in useconds */
> > -gb_loopback_ro_attr(timeout_max);
> > +declare_gb_loopback_ro_attr(timeout_max);
> >   /*
> >    * Type of loopback message to send based on protocol type definitions
> > @@ -297,21 +297,21 @@ gb_loopback_ro_attr(timeout_max);
> >    *					   payload returned in response)
> >    * 4 => Send a sink message (message with payload, no payload in response)
> >    */
> > -gb_dev_loopback_rw_attr(type, d);
> > +declare_gb_dev_loopback_rw_attr(type, d);
> >   /* Size of transfer message payload: 0-4096 bytes */
> > -gb_dev_loopback_rw_attr(size, u);
> > +declare_gb_dev_loopback_rw_attr(size, u);
> >   /* Time to wait between two messages: 0-1000 ms */
> > -gb_dev_loopback_rw_attr(us_wait, d);
> > +declare_gb_dev_loopback_rw_attr(us_wait, d);
> >   /* Maximum iterations for a given operation: 1-(2^32-1), 0 implies infinite */
> > -gb_dev_loopback_rw_attr(iteration_max, u);
> > +declare_gb_dev_loopback_rw_attr(iteration_max, u);
> >   /* The current index of the for (i = 0; i < iteration_max; i++) loop */
> > -gb_dev_loopback_ro_attr(iteration_count, false);
> > +declare_gb_dev_loopback_ro_attr(iteration_count, false);
> >   /* A flag to indicate synchronous or asynchronous operations */
> > -gb_dev_loopback_rw_attr(async, u);
> > +declare_gb_dev_loopback_rw_attr(async, u);
> >   /* Timeout of an individual asynchronous request */
> > -gb_dev_loopback_rw_attr(timeout, u);
> > +declare_gb_dev_loopback_rw_attr(timeout, u);
> >   /* Maximum number of in-flight operations before back-off */
> > -gb_dev_loopback_rw_attr(outstanding_operations_max, u);
> > +declare_gb_dev_loopback_rw_attr(outstanding_operations_max, u);
> >   static struct attribute *loopback_attrs[] = {
> >   	&dev_attr_latency_min.attr,
> > 
> 
