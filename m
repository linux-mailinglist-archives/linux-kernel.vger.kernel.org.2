Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8EB45423F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 09:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbhKQIDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 03:03:35 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:46013 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhKQIDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 03:03:34 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 29E903000FD73;
        Wed, 17 Nov 2021 09:00:35 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 1CB2319436; Wed, 17 Nov 2021 09:00:35 +0100 (CET)
Date:   Wed, 17 Nov 2021 09:00:35 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Bao, Joseph" <joseph.bao@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        "kw@linux.com" <kw@linux.com>
Subject: Re: HW power fault defect cause system hang on kernel 5.4.y
Message-ID: <20211117080035.GA18186@wunner.de>
References: <DM8PR11MB5702255A6A92F735D90A4446868B9@DM8PR11MB5702.namprd11.prod.outlook.com>
 <20211115192723.GA19161@wunner.de>
 <DM8PR11MB57020A22195E69295C5A9B8886999@DM8PR11MB5702.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB57020A22195E69295C5A9B8886999@DM8PR11MB5702.namprd11.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 02:42:20AM +0000, Bao, Joseph wrote:
> I've tested this tentative patch, and it fixes the issue.

Bjorn, do you want me to resend the fix as a proper patch
(instead of appended to an e-mail) for visibility?

If so, do you have any change requests that I should fold in?

Link to the fix:
https://lore.kernel.org/linux-pci/20211115192723.GA19161@wunner.de/

Thanks,

Lukas
