Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F513BA0AC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 14:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbhGBMtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 08:49:07 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2906 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232168AbhGBMtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 08:49:06 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 162ChIOK014864;
        Fri, 2 Jul 2021 12:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=y+x0gMSoAlgZfFtMtzPP543h3n4CIJHx0eM6clBv3t0=;
 b=OT0Rc1wmF2oxISppt8czhArALn5rN8iF0rit9PRpd3QA1a7i/NIxAYQe+Q8b7FPt+xhT
 jye3BAIfTdiYaCOFdqrn9gSojTw2dC44FwHt7StEJ0horR0dsS1WTPeEAVUpIf4h5SQz
 S0l/g34y9BrG3oI+h/jKNyA3MAN7WeqQOfVjVzZqadYKg92FtC/cF7lk2SL/9c3ePMYe
 8NFDMAdzel/pobROkaswaYIz6SasPHJP1CTm7wFuAELsqzCSE6d8bK6K9mM0HWz6GGyb
 pB3YN6CqN54xQlPoIFGlAdMT5k7ubPsXNKKc0jlc9/QZKXBK+yU/GGzBkh5+lwRaiN5c PQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39gguq5d49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jul 2021 12:46:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 162CkIZs114040;
        Fri, 2 Jul 2021 12:46:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 39ee13726j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jul 2021 12:46:21 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 162CkLMg114527;
        Fri, 2 Jul 2021 12:46:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 39ee13725f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jul 2021 12:46:21 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 162CkJoX025135;
        Fri, 2 Jul 2021 12:46:19 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Jul 2021 05:46:18 -0700
Date:   Fri, 2 Jul 2021 15:46:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: Remove an unused variable and some
 lines of code
Message-ID: <20210702124606.GY1983@kadam>
References: <20210701144707.22820-1-fmdefrancesco@gmail.com>
 <20210702074840.GT2040@kadam>
 <20210702083521.GV2040@kadam>
 <2153683.Tj7f0gbxMR@linux.local>
 <20210702124225.GW2040@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702124225.GW2040@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: Rxt2PLGvwT3kpmVTib8gxXAV6FrOxcJI
X-Proofpoint-GUID: Rxt2PLGvwT3kpmVTib8gxXAV6FrOxcJI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You should write that at the start of the commit message.

This driver doesn't support SIOCSIWRATE.  It just returns zero and does
nothing.  Change it to return -ENOTSUPP instead.  (This is an API change
but we don't expect it to break anything).

regards,
dan carpenter

