Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C71540CEA6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 23:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbhIOVOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 17:14:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47404 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232760AbhIOVNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 17:13:41 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18FIgMfw003228;
        Wed, 15 Sep 2021 17:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=LsQZc/VaDEkUhYmxVD4r3oz4fRVG/JeSgvVFMFDWv9c=;
 b=b6UrA8WR1EVbYudR5Fe8U+I3pC9EIYmfq3WGwAmX8zrCxYqO2H23xYocHo96+AXuCezN
 hQ5oxrl+8XNYqV1aoEIGs6p/dNR2IpILLGfBa+cjP65mu4CGoeUQmYn0HlggZ601eiRa
 n+znGs+Cy3AbIe081MZoyXdJggaxA8HKIivrAjA/wvr88SL6H87+ck4LpZQAU6YORdkh
 ENwjb9z7BP3f7jNNi1pYuTFv7k/puQHhmRhYG6TZng0uIg6V47KmIGkxz+dAYsx1X9hh
 nKj/LpazCFr4NlBjYq/50mnCyRjKcwrgVMViEKdeLZ/uPjCtGxfY/c4BJSvW2XTrBmHO IQ== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b3p60tuvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Sep 2021 17:11:53 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18FL6ssO020495;
        Wed, 15 Sep 2021 21:11:52 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01dal.us.ibm.com with ESMTP id 3b0m3e1ffy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Sep 2021 21:11:52 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18FLBpMx8782340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 21:11:51 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5ED1A6E058;
        Wed, 15 Sep 2021 21:11:51 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB2456E050;
        Wed, 15 Sep 2021 21:11:50 +0000 (GMT)
Received: from v0005c16 (unknown [9.211.152.249])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 15 Sep 2021 21:11:50 +0000 (GMT)
Message-ID: <ac8d30e988ab6cc16d4c7446d259b87deb734910.camel@linux.ibm.com>
Subject: Re: [PATCH 3/3] hwmon: (occ) Provide the SBEFIFO FFDC in binary
 sysfs
From:   Eddie James <eajames@linux.ibm.com>
To:     Guenter Roeck <linux@roeck-us.net>, joel@jms.id.au
Cc:     linux-fsi@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com,
        alistair@popple.id.au, jk@ozlabs.org
Date:   Wed, 15 Sep 2021 16:11:50 -0500
In-Reply-To: <20210915161333.GA3712393@roeck-us.net>
References: <20210914213543.73351-1-eajames@linux.ibm.com>
         <20210914213543.73351-4-eajames@linux.ibm.com>
         <20210915161333.GA3712393@roeck-us.net>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UQO9fl-rjOiohgIRRn4ZoEFvuPM2np_y
X-Proofpoint-ORIG-GUID: UQO9fl-rjOiohgIRRn4ZoEFvuPM2np_y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109150103
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-09-15 at 09:13 -0700, Guenter Roeck wrote:
> On Tue, Sep 14, 2021 at 04:35:43PM -0500, Eddie James wrote:
> > Save any FFDC provided by the OCC driver, and provide it to
> > userspace
> > through a binary sysfs entry. Do some basic state management to
> > ensure that userspace can always collect the data if there was an
> > error. Notify polling userspace when there is an error too.
> > 
> > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> 
> This is now the 2nd series that we have pending, and the first series
> (from July) still didn't make it into the upstream kernel because the
> fsi code
> seems to go nowhere. Any chance to address that ?

Yes... Joel, can we merge that? I don't have any comments to address.

> 
> Additional comment inline.
> 
> Thanks,
> Guenter
> 
> > ---
> >  drivers/hwmon/occ/p9_sbe.c | 98
> > +++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 97 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hwmon/occ/p9_sbe.c
> > b/drivers/hwmon/occ/p9_sbe.c
> > index 9709f2b9c052..505f489832a4 100644
> > --- a/drivers/hwmon/occ/p9_sbe.c
> > +++ b/drivers/hwmon/occ/p9_sbe.c
> > @@ -4,18 +4,54 @@
> >  #include <linux/device.h>
> >  #include <linux/errno.h>
> >  #include <linux/fsi-occ.h>
> > +#include <linux/mm.h>
> >  #include <linux/module.h>
> > +#include <linux/mutex.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/string.h>
> > +#include <linux/sysfs.h>
> >  
> >  #include "common.h"
> >  
> > +enum sbe_error_state {
> > +	SBE_ERROR_NONE = 0,
> > +	SBE_ERROR_PENDING,
> > +	SBE_ERROR_COLLECTED
> > +};
> > +
> >  struct p9_sbe_occ {
> >  	struct occ occ;
> > +	int sbe_error;
> > +	void *ffdc;
> > +	size_t ffdc_len;
> > +	size_t ffdc_size;
> > +	struct mutex sbe_error_lock;	/* lock access to ffdc data
> > */
> > +	u32 no_ffdc_magic;
> >  	struct device *sbe;
> >  };
> >  
> >  #define to_p9_sbe_occ(x)	container_of((x), struct p9_sbe_occ,
> > occ)
> >  
> > +static ssize_t sbe_error_read(struct file *filp, struct kobject
> > *kobj,
> > +			      struct bin_attribute *battr, char *buf,
> > +			      loff_t pos, size_t count)
> > +{
> > +	ssize_t rc = 0;
> > +	struct occ *occ = dev_get_drvdata(kobj_to_dev(kobj));
> > +	struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
> > +
> > +	mutex_lock(&ctx->sbe_error_lock);
> > +	if (ctx->sbe_error == SBE_ERROR_PENDING) {
> > +		rc = memory_read_from_buffer(buf, count, &pos, ctx-
> > >ffdc,
> > +					     ctx->ffdc_len);
> > +		ctx->sbe_error = SBE_ERROR_COLLECTED;
> > +	}
> > +	mutex_unlock(&ctx->sbe_error_lock);
> > +
> > +	return rc;
> > +}
> > +static BIN_ATTR_RO(sbe_error, OCC_MAX_RESP_WORDS * 4);
> > +
> >  static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd, size_t
> > len)
> >  {
> >  	struct occ_response *resp = &occ->resp;
> > @@ -24,8 +60,47 @@ static int p9_sbe_occ_send_cmd(struct occ *occ,
> > u8 *cmd, size_t len)
> >  	int rc;
> >  
> >  	rc = fsi_occ_submit(ctx->sbe, cmd, len, resp, &resp_len);
> > -	if (rc < 0)
> > +	if (rc < 0) {
> > +		if (resp_len) {
> > +			bool notify = false;
> > +
> > +			mutex_lock(&ctx->sbe_error_lock);
> > +			if (ctx->sbe_error != SBE_ERROR_PENDING)
> > +				notify = true;
> > +			ctx->sbe_error = SBE_ERROR_PENDING;
> > +
> > +			if (resp_len > ctx->ffdc_size) {
> > +				if (ctx->ffdc_size)
> > +					kvfree(ctx->ffdc);
> > +				ctx->ffdc = kvmalloc(resp_len,
> > GFP_KERNEL);
> > +				if (!ctx->ffdc) {
> > +					ctx->ffdc_size = 0;
> > +					ctx->ffdc_len = sizeof(u32);
> > +					ctx->ffdc = &ctx-
> > >no_ffdc_magic;
> > +					goto unlock;
> > +				}
> > +
> > +				ctx->ffdc_size = resp_len;
> > +			}
> > +
> > +			ctx->ffdc_len = resp_len;
> > +			memcpy(ctx->ffdc, resp, resp_len);
> > +
> > +unlock:
> > +			mutex_unlock(&ctx->sbe_error_lock);
> > +
> > +			if (notify)
> > +				sysfs_notify(&occ->bus_dev->kobj, NULL,
> > +					     bin_attr_sbe_error.attr.na
> > me);
> > +		}
> > +
> >  		return rc;
> > +	}
> > +
> > +	mutex_lock(&ctx->sbe_error_lock);
> > +	if (ctx->sbe_error == SBE_ERROR_COLLECTED)
> > +		ctx->sbe_error = SBE_ERROR_NONE;
> > +	mutex_unlock(&ctx->sbe_error_lock);
> 
> I am not entirely sure I understand the benefit of
> SBE_ERROR_COLLECTED.
> Can you explain why it is needed, and why the status is not just set
> to SBE_ERROR_NONE after the error data was collected ?

The purpose was to make sure the data can be collected even if a
successful transfer (which clears the flag) comes through before the
user comes and reads the file. If the error is just set to NONE, then
the user might never see it, with the current implementation. I think I
will drop the state management though and just return the last error
data.

> 
> >  
> >  	switch (resp->return_status) {
> >  	case OCC_RESP_CMD_IN_PRG:
> > @@ -65,6 +140,13 @@ static int p9_sbe_occ_probe(struct
> > platform_device *pdev)
> >  	if (!ctx)
> >  		return -ENOMEM;
> >  
> > +	ctx->no_ffdc_magic = OCC_NO_FFDC_MAGIC;
> 
> This is ... odd. Why not just return a file size of 0 if there is no
> data ?
> The binary file is an ABI and needs to be documented, including the
> use
> of this "magic". The use of that magic needs to be explained because
> it
> does add a lot of what sems to be unnecessary complexity to the code.
> 
> Besides, most of that complexity seems unnecessary: If the magic is
> really
> needed, the read code could just write it into the buffer if ctx-
> >ffdc
> is NULL. There is a lot of complexity just to avoid an if statement
> in
> sbe_error_read().

Yea, I will admit this is pretty awkward. The reason for all this is
because I was trying to use a single sysfs entry to communicate both
whether or not there is an error at all, and the data from the error.
So returning  file size 0 means "no error" and then we can't capture
the case where there is an error but there is no data.

So on second thought, I should probably use two sysfs entries: one to
indicate if there is an error, and the other to report the data (if
there is any). There is the existing OCC error file of course, but
that's supposed to be for actual OCC response errors, so I will have to
investigate if it can serve both purposes.

Thanks for the review, Guenter!
Eddie

> 
> > +	ctx->sbe_error = SBE_ERROR_NONE;
> > +	ctx->ffdc = &ctx->no_ffdc_magic;
> > +	ctx->ffdc_len = sizeof(u32);
> > +	ctx->ffdc_size = 0;
> > +	mutex_init(&ctx->sbe_error_lock);
> > +
> >  	ctx->sbe = pdev->dev.parent;
> >  	occ = &ctx->occ;
> >  	occ->bus_dev = &pdev->dev;
> > @@ -78,6 +160,15 @@ static int p9_sbe_occ_probe(struct
> > platform_device *pdev)
> >  	if (rc == -ESHUTDOWN)
> >  		rc = -ENODEV;	/* Host is shutdown, don't spew
> > errors */
> >  
> > +	if (!rc) {
> > +		rc = device_create_bin_file(occ->bus_dev,
> > &bin_attr_sbe_error);
> > +		if (rc) {
> > +			dev_warn(occ->bus_dev,
> > +				 "failed to create SBE error ffdc
> > file\n");
> > +			rc = 0;
> > +		}
> > +	}
> > +
> >  	return rc;
> >  }
> >  
> > @@ -86,9 +177,14 @@ static int p9_sbe_occ_remove(struct
> > platform_device *pdev)
> >  	struct occ *occ = platform_get_drvdata(pdev);
> >  	struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
> >  
> > +	device_remove_bin_file(occ->bus_dev, &bin_attr_sbe_error);
> > +
> >  	ctx->sbe = NULL;
> >  	occ_shutdown(occ);
> >  
> > +	if (ctx->ffdc_size)
> > +		kvfree(ctx->ffdc);
> > +
> >  	return 0;
> >  }
> >  
> > -- 
> > 2.27.0
> > 

