Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640533B7812
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 20:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbhF2S6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 14:58:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:35534 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233859AbhF2S6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 14:58:22 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15TIkgPV027056;
        Tue, 29 Jun 2021 18:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Uez3zmCeo9MNeRjvJ2k7OPOSq3odxVfykahqSpzgico=;
 b=JxAQtA0rokHvkBWQtf4P4W+VTGJEZMA3prc6VqTFWqD0blSfT/+YQDrGJqyxSBjium3d
 ViZctl7+56KZgZlko101GG4dMVmkOF4UDX7RterIYnMvqW+BMi/D8QUbgXoyJEA1pfUM
 gcKNqeiPAWxi4toT43XWNcWjGtFrnW7FTYNTXLnvLjaIG0dsry7mCrnHJORgo86IS/3+
 l73PkfVvfiR5dX+rrJAH6Fm+lAluKrG+MAtM/4ESC34qmUycCWqXpfs4DKivVypAK8Tq
 HjppvOV4BohQ/kwiyf+o9lB7dMcCyd3JYJDuQ8z02WRzbWQt1dGpNArWYWTs5aFi8Lqy ZQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39f174mhru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 18:55:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15TIk5Md146027;
        Tue, 29 Jun 2021 18:55:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 39dt9febbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 18:55:24 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15TItN2D174336;
        Tue, 29 Jun 2021 18:55:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 39dt9febax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 18:55:23 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15TItLVo020629;
        Tue, 29 Jun 2021 18:55:21 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Jun 2021 11:55:20 -0700
Date:   Tue, 29 Jun 2021 21:55:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH][next] trace: osnoise: Fix u64 less than zero comparison
Message-ID: <20210629185513.GC1983@kadam>
References: <20210629165245.42157-1-colin.king@canonical.com>
 <c74e711e-71c9-df9c-8406-b9e92ef12da0@redhat.com>
 <e36f61af-4fbe-42cf-f26d-229f940e8fc9@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e36f61af-4fbe-42cf-f26d-229f940e8fc9@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: DeMh1JNdm_WOGmIMMpKCkAIBZcWIScLp
X-Proofpoint-ORIG-GUID: DeMh1JNdm_WOGmIMMpKCkAIBZcWIScLp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 06:21:32PM +0100, Colin Ian King wrote:
> On 29/06/2021 18:19, Daniel Bristot de Oliveira wrote:
> > On 6/29/21 6:52 PM, Colin King wrote:
> >> From: Colin Ian King <colin.king@canonical.com>
> >>
> >> The less than zero comparison of the u64 variable 'noise' is always
> >> false because the variable is unsigned. Since the time_sub macro
> >> can potentially return an -ve vale, make the variable a s64 to
> >> fix the issue.
> > 
> > Ops! concurrent bug fixing.
> 
> Well, shows static analysis is doing it's thing and I'm not being
> vigilant enough by spotting that Dan found it earlier :-)

Nah.  I don't normally CC kernel-janitors on bug reports.  I sometimes
do on netdev stuff because Dave told me ten years ago that static
analysis noise on the list was an annoying thing.  And actually on that
one I didn't CC anyone actually, Oops.

regards,
dan carpenter

