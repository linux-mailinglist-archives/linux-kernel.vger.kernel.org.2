Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703A4428CB0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 14:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbhJKMKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 08:10:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234685AbhJKMKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 08:10:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9EC2460E53;
        Mon, 11 Oct 2021 12:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633954128;
        bh=IT3t3XgP/5S/lmjBcscARvCUhacZFc66W6PEzZMK9Vk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NRlepPxtJgXwIn3z57SGNUr16AgbtWX+MwJLf3vlOMabjWOsxqlk5rBdwg7pfxY9X
         19CBuJ+ZqdVsNLnrspaw8fW6FIopOSCM3HEQ+CAKFZrrRzHPECXLWQc7b62lgTYgUc
         eQ9XfXseJby1BWS6zA7Zr/wENL9kYRnxpGbREjH8y0u1xgNlsGpMhTq57u74GzoFYK
         gwoqJGoXV7TdiUrDeEvQxv0wKJhckS8Uz+G3hjQpZ5shAArQ/f9I+9nLl/XQYA/cHR
         xiajmP7qvLb63SkK8V0mrL7kvdJJbVqVq1IG0gilXdt4iNs0077MyKzBwpJF/ho74i
         IXxlqT2p5l2FA==
Date:   Mon, 11 Oct 2021 13:08:42 +0100
From:   Will Deacon <will@kernel.org>
To:     Bhaskara Budiredla <bbudiredla@marvell.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/2] drivers: perf: Add Marvell CN10K LLC-TAD pmu
 driver
Message-ID: <20211011120842.GA4297@willie-the-truck>
References: <20210908120425.10084-1-bbudiredla@marvell.com>
 <CY4PR1801MB207038FD04A714BF15DA88A3DEAA9@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CY4PR1801MB2070E39832569F339D8F9439DEB19@CY4PR1801MB2070.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR1801MB2070E39832569F339D8F9439DEB19@CY4PR1801MB2070.namprd18.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 06:30:43AM +0000, Bhaskara Budiredla wrote:
> Do you have anything to add?

I need to go through this again, but I haven't found the time yet.

One big thing you could do to help would be to review this other PMU
driver from your colleague on the mailing list:

https://lore.kernel.org/r/20210920050823.10853-1-bbhushan2@marvell.com

and vice-versa.

Will
