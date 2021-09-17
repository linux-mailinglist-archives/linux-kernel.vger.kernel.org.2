Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1709040FF94
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 20:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245605AbhIQSqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 14:46:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44166 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242488AbhIQSpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 14:45:53 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18HHTwat021947;
        Fri, 17 Sep 2021 14:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Cu15NbkF8XCdYMaWhSe53yZzJsAWowt8+l6QazcJZNo=;
 b=EyWbQgraP/K7m+gWE1cBSBSq3lkKpWPmJw4h7wvEJq9WqrGlNwz+PN+HX/zijvjZVadE
 JJZF04SeKNDXzp275UT+7gM9tL2AhiqF9fXcJdkiQfyY1zx+SXC/z4ACwPD02rb3FakD
 ttsn3hQmvCpvxQa0grIRXDMFEJ5t7C4PQR5TAps0jIy67nMptkie22mew0HGY9tJWS8A
 /NFvz+cwsiFLecEXsPXOIkWdNYAIrz5+s2f2piJmaObMkcorBBs2U9U1oXnbse2NwQZX
 Kmlio6xHzas581J9QOdiWvojg1al7LziPzM4tFfbJiZaZrGZLHO43tEkBIqweWEb908m Jg== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b4hdddvdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Sep 2021 14:44:05 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18HIHvT8025067;
        Fri, 17 Sep 2021 18:44:03 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 3b4m7ptj73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Sep 2021 18:44:03 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18HIi24144302716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Sep 2021 18:44:02 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8079AE062;
        Fri, 17 Sep 2021 18:44:02 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DF46AE05F;
        Fri, 17 Sep 2021 18:44:02 +0000 (GMT)
Received: from v0005c16 (unknown [9.211.95.114])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 17 Sep 2021 18:44:01 +0000 (GMT)
Message-ID: <24039f18c446432064cf1dfcd59992ba7d4e9973.camel@linux.ibm.com>
Subject: Re: [PATCH 3/3] hwmon: (occ) Provide the SBEFIFO FFDC in binary
 sysfs
From:   Eddie James <eajames@linux.ibm.com>
To:     Jeremy Kerr <jk@codeconstruct.com.au>, linux-fsi@lists.ozlabs.org
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@jms.id.au, linux@roeck-us.net, jdelvare@suse.com,
        alistair@popple.id.au
Date:   Fri, 17 Sep 2021 13:44:01 -0500
In-Reply-To: <ad29d1d9743799ffd770330af6ad174bdfe7c3a0.camel@codeconstruct.com.au>
References: <20210914213543.73351-1-eajames@linux.ibm.com>
         <20210914213543.73351-4-eajames@linux.ibm.com>
         <ad29d1d9743799ffd770330af6ad174bdfe7c3a0.camel@codeconstruct.com.au>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BaMSJvgU7cT0tdKrrutyp7DqLrUjzNOS
X-Proofpoint-ORIG-GUID: BaMSJvgU7cT0tdKrrutyp7DqLrUjzNOS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-17_07,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109170110
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-09-16 at 08:17 +0800, Jeremy Kerr wrote:
> Hi Eddie,
> 
> > Save any FFDC provided by the OCC driver, and provide it to
> > userspace
> > through a binary sysfs entry. Do some basic state management to
> > ensure that userspace can always collect the data if there was an
> > error. Notify polling userspace when there is an error too.
> 
> Super! Some comments inline:
> 
> > +enum sbe_error_state {
> > +       SBE_ERROR_NONE = 0,
> > +       SBE_ERROR_PENDING,
> > +       SBE_ERROR_COLLECTED
> > +};
> > +
> >  struct p9_sbe_occ {
> >         struct occ occ;
> > +       int sbe_error;
> 
> Use the enum here?

Yep :) Though I think I will switch to a bool; as I wrote to Guenter,
the extra "collected" state isn't necessary if I stop trying to report
two things (the FFDC itself and whether or not there is an error at
all) with one interface.

> 
> > +       void *ffdc;
> > +       size_t ffdc_len;
> > +       size_t ffdc_size;
> > +       struct mutex sbe_error_lock;    /* lock access to ffdc data
> > */
> > +       u32 no_ffdc_magic;
> >         struct device *sbe;
> >  };
> >  
> >  #define to_p9_sbe_occ(x)       container_of((x), struct
> > p9_sbe_occ, occ)
> >  
> > +static ssize_t sbe_error_read(struct file *filp, struct kobject
> > *kobj,
> > +                             struct bin_attribute *battr, char
> > *buf,
> > +                             loff_t pos, size_t count)
> > +{
> > +       ssize_t rc = 0;
> > +       struct occ *occ = dev_get_drvdata(kobj_to_dev(kobj));
> > +       struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
> > +
> > +       mutex_lock(&ctx->sbe_error_lock);
> > +       if (ctx->sbe_error == SBE_ERROR_PENDING) {
> > +               rc = memory_read_from_buffer(buf, count, &pos, ctx-
> > >ffdc,
> > +                                            ctx->ffdc_len);
> > +               ctx->sbe_error = SBE_ERROR_COLLECTED;
> > +       }
> > +       mutex_unlock(&ctx->sbe_error_lock);
> > +
> > +       return rc;
> > +}
> 
> So any read from this file will clear out the FFDC data, making
> partial
> reads impossible. As a least-intrusive change, could we set
> SBE_ERROR_COLLECTED on write instead?

Good point. Write would work. How about resetting the error flag once
pos >= size though, for the sake of simplicity?

> 
> Or is there a better interface (a pipe?) that allows multiple FFDC
> captures, destroyed on full consume, without odd read/write side
> effects?

I tried to look into pipes, but I'm pretty unclear on how to set one
up. Doesn't appear as though they are used in kernel much, especially
as an interface to userspace.
I'm just not sure its worth having more than one FFDC packet available.
There would always have to be a maximum number of them anyway to put a
bound on memory usage. We're somewhat helped here by the fact that OCC
operations will go out a maximum of once a second, so that's hopefully
plenty of time for userspace to notice the error and pick up the FFDC.

> 
> >         rc = fsi_occ_submit(ctx->sbe, cmd, len, resp, &resp_len);
> > -       if (rc < 0)
> > +       if (rc < 0) {
> > +               if (resp_len) {
> > +                       bool notify = false;
> > +
> > +                       mutex_lock(&ctx->sbe_error_lock);
> > +                       if (ctx->sbe_error != SBE_ERROR_PENDING)
> > +                               notify = true;
> > +                       ctx->sbe_error = SBE_ERROR_PENDING;
> 
>                           [...]
> 
> > +                       ctx->ffdc_len = resp_len;
> > +                       memcpy(ctx->ffdc, resp, resp_len);
> 
> This will clear out the previous error it if hasn't been collected by
> userspace. Is that really what you want for *first* fail data
> capture?
> :)

Ah, good point. I will fix that!

Thanks for the review Jeremy!

Eddie

> 
> Cheers,
> 
> 
> Jeremy
> 

