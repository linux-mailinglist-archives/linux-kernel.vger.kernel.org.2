Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7325F3B2FC9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 15:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhFXNKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 09:10:38 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:12078 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230334AbhFXNKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 09:10:37 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15OD2a0s023210;
        Thu, 24 Jun 2021 13:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=z23PjgTmLC29IXOSx5a61Z5SV0NvKUAcMncLyaS40jw=;
 b=PmcV4wuFeH8NGfaWOKv64iJuzYPdg6LGpbKE3ut22EMW6lbspRh9Tn0GWpQ/byx57j69
 y0+IMcUZvCS/AUKzSnxxpuTQ90DjoEXkb8X2cMiSfYB5Fm/49v65zB/eSiEHWLmbJlLQ
 LdGuuvweLJvBMfcPLMLEJH4kUiszGOrXiXPIF/8SW+oN9R+xHikTWAv1/0xQrfNp9AWw
 IEpz7eKEzyfEEzupBkZupGQkvR2Bu9XNkrBPXJHjeaYqflKaFidaNxgPhA3Qt3yZZLIo
 w2QOwuFOuEEGnnDagGyQDaGW7wJiIAUKGzpOJiR3Z/fPqOWmf7VlSXobtggOqMP/yO8n TQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39cmpxgv9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jun 2021 13:08:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15OD5ZrD008754;
        Thu, 24 Jun 2021 13:08:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3998dah81h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jun 2021 13:08:05 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15OD6l9a014384;
        Thu, 24 Jun 2021 13:08:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 3998dah80x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jun 2021 13:08:04 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15OD82gn023069;
        Thu, 24 Jun 2021 13:08:02 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Jun 2021 06:08:01 -0700
Date:   Thu, 24 Jun 2021 16:07:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH RESEND v6 6/8] mfd: hi6421-spmi-pmic: move driver from
 staging
Message-ID: <20210624130749.GF2040@kadam>
References: <cover.1624525118.git.mchehab+huawei@kernel.org>
 <1ad2cbbd182d18ba2cae716fb5f1497b1cabbdbe.1624525118.git.mchehab+huawei@kernel.org>
 <YNRrISOGujxcJAGR@dell>
 <20210624143605.153e1e34@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624143605.153e1e34@coco.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: jP_qNZhRMPI-THas6DKnfLV_wLe91_Dl
X-Proofpoint-GUID: jP_qNZhRMPI-THas6DKnfLV_wLe91_Dl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 02:36:05PM +0200, Mauro Carvalho Chehab wrote:
> Em Thu, 24 Jun 2021 12:33:28 +0100
> Lee Jones <lee.jones@linaro.org> escreveu:
> 
> > On Thu, 24 Jun 2021, Mauro Carvalho Chehab wrote:
> > > +static void hi6421_spmi_pmic_remove(struct spmi_device *pdev)
> > > +{
> > > +	struct hi6421_spmi_pmic *ddata = dev_get_drvdata(&pdev->dev);
> > > +
> > > +	free_irq(ddata->irq, ddata);  
> > 
> > No devm_* version?
> 
> Are there a devm_* variant for gpio_to_irq()?
> 

It's the request_threaded_irq() which needs unwound not the gpio_to_irq()
so you could use devm_request_threaded_irq().

Using the devm_ version would fix a leak in probe which Smatch is
supposed to find but does not.  :(

regards,
dan carpenter
