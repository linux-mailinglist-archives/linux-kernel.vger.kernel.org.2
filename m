Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A4A3F9D20
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 18:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbhH0Q5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 12:57:49 -0400
Received: from mout.gmx.net ([212.227.15.19]:58213 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231163AbhH0Q5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 12:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630083414;
        bh=iCVCBhOXLykLfL9yI3qVBnspovBFQXhfwcA8yOfrTqY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=RNVycgV1FM3aAYjbxqrTu2v1JX9OxuuZRs54Mp7euUXcaDpemCYPn81Qc6AgPL5J7
         a/Ue0nzy7qlYq5wnZ8+sjrxAHwcRMJjgWtRDmO+IXHY9BKA47WAmys1K8RSRFuY6BR
         BRjMOTffdnYS5R8wgol2GUInE69uFZFEEKae/CFQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MhlKs-1mxNgs0mzA-00dnc7; Fri, 27
 Aug 2021 18:56:54 +0200
Date:   Fri, 27 Aug 2021 18:56:42 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Len Baker <len.baker@gmx.com>, linux-kernel@vger.kernel.org,
        kernelnewbies@kernelnewbies.org
Subject: Re: Contributing to drivers/staging area
Message-ID: <20210827165642.GA2070@titan>
References: <20210820144515.GA5479@titan>
 <YSdTOBBAMPIBVFcW@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSdTOBBAMPIBVFcW@kroah.com>
X-Provags-ID: V03:K1:KSi2UWuC4Aj6OqQLFfQ8CzlLDf6mHYraqO/+3NbRGsU5rySo+7I
 wFwcOIK7W/QDZwrXDye9w7PdySBX2g+8Vh6PIEjwgtI+MwgwoP2JDfQRE1sZ/6lAhKY7P8I
 g2tE9J/sN4+6iBVTosbo290uzg6iRCitvjj3ZJf41a1Bcu25yUaDjuD1JAdGlRVQEvubqA6
 1AwI7IsNUBexmaPe2KZzg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gyqaNIrvnJI=:l38f++YHTqhSQhcyfQRysu
 5o+Fth8+ja4orhRNnUTsX95LX7W0fO5f4zHkS2iiYzT2jv+c0XJEY/DDm7P4z+JCaLwSeSOqk
 5ygK0gVoqkHNVKLzLnB5X97MPKrCBOSGebUGEQuzXokKuBrQbebQtn4HhihDv+XhsWN5Z+mMZ
 wvKgfxNn9lMr3EjYdPfSvXtpGpWlW0XT6unZabvsrlC3CPJ+aQ4qcaLxdbk04m+mI2ZED6rEB
 qY1lFZsIw/gCMUPQEChU4jp29ThFLsUxZsoYDUv+sG4j+arfmoXRWwSaSBxmAavAIIFDsQKQu
 IYUM/JKdnntMG3EbyGjKpipHqa/nvg2Il6u46GWkEeH6OhPnQ1vtdMMYZY8TVZftP2W3tcMy8
 KIRBkD4dw7X8BNGmyKhfabDwb0K2XHxhHMjSSGTzwEd6feRRF+zK8NxIqEEAlHeCNEZphyCyg
 qXj6g6h8UkiN9BPqM3vC0u9zcaz2CcHaasn0bMbXDEpLJ0q66mPXc8TYTdJVxetZG1YTIlHDk
 8qRk6trwsAm6XgnSZM9XFm6DsVwKA88iDvguKyQDHwfj6MXlvc47Cm42i/mIfzstFIBei8FRq
 L884OPozzYyUK8Wj9ERO0P9zRX8a8q4TOME15wVleN9LsiuMnmWVB5Hs1EykMtDCkWZz4N2Ww
 W7+MJHPu6sYHqB7EjSpvRzGZVsTlzXLUwtPG9YiEr00Bmjfv8nzZ8hWNaOj2R8qOIBzdHR5du
 T2fze67h28AxdfqTLcV0b2WhiuWtB+q4pPAX+7W7kojrpvLBG6Urz3FQxOWQ7Lsb6jo/24UL/
 7OHKMX/LD7zdwHs4pNjSlOArVGbi93vLzTQ3LDfvaAMxDPqiXteY2/7otUCmql1Yp9F8xkSG7
 2R3sluyXkJ7vAXXlY3Dk9VHVceyxI/8k2jS1g9mqAfQ6fV3SNq2BPZ5chog2vD+MNdpSgf6Ow
 hZvI21823BxuaZR+i7isSet8iyoL8dS3I/NYCkrTF/2Vl5TuGYPOj7LxJipcKTOFhyhBm61rA
 plquUixskXK0m9eoSyKWkjLpX0Hbsx0BVImixgyWvYWa7pgne8moHO8U/erPdtZoLoMELaZJt
 vGdqcyvSLPK+ZwV82CW8PgAcJf4bDpfXaR7Z6gRQtmdGS6iVPk1XntmAQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Aug 26, 2021 at 10:39:20AM +0200, Greg KH wrote:
> On Fri, Aug 20, 2021 at 04:45:15PM +0200, Len Baker wrote:
> > Hi Greg,
> >
> > I am a kernel newbie in the path to find an area where to contribute
> > on. I have sent some patches before (simple ones) but I would like
> > to find some driver to contribute on and if possible mantain in the
> > future. Due to the big amount of drivers in staging, and my lack
> > of experience and specific hardware:
> >
> > Are there any driver in the staging area that not requires specific
> > hardware? I have only access to an old laptop with 4 processors:
>
> I think all drivers in staging relate to real hardware, so I would
> recommend just buying one of the cheap devices for the drivers.  I just
> purchased one of the USB wifi devices for under 20 euros, so it is
> possible.

Ok, thank you very much for all the info and advices.
Again, thanks for your time.

Regards,
Len
