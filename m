Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D285F3B2D96
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 13:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbhFXLRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 07:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbhFXLRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 07:17:41 -0400
Received: from canardo.mork.no (canardo.mork.no [IPv6:2001:4641::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA249C061767;
        Thu, 24 Jun 2021 04:15:22 -0700 (PDT)
Received: from miraculix.mork.no ([IPv6:2a01:79d:469a:7994:53d7:1944:55a:91c0])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id 15OBFDT7018095
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 24 Jun 2021 13:15:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1624533313; bh=5b6YZR358Wi3JQ4ZkLcOC7UPJZD+b3tWEuj0//aMkNs=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=O0PHfPOg0NEtLdTjAcRzOnviAPE6+Qp8ZQG+7BMcaB0PpbYu6dhN1sOyWlXiVWq6x
         s1FJiPCPYJR74dn4yRqaSjW7FfcpHR5e1Ot4ChS6M8Cfr1gaH4S8K8/SvJzOKgZ27K
         LSOp2TFqutnCyqCmGVhBnxodi2qpBiw1HZPncFfA=
Received: from bjorn by miraculix.mork.no with local (Exim 4.94.2)
        (envelope-from <bjorn@mork.no>)
        id 1lwNK7-001FQQ-Ut; Thu, 24 Jun 2021 13:15:07 +0200
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Johan Hovold <johan@kernel.org>
Cc:     Stefan =?utf-8?Q?Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniele Palmas <dnlplm@gmail.com>
Subject: Re: [PATCH v2] USB: serial: qcserial: Support for SDX55 based
 Sierra Wireless 5G modules
Organization: m
References: <20210611134507.8780-1-stefan.bruens@rwth-aachen.de>
        <20210611135842.14415-1-stefan.bruens@rwth-aachen.de>
        <YNQ0O0vhtpStp0n/@hovoldconsulting.com>
Date:   Thu, 24 Jun 2021 13:15:07 +0200
In-Reply-To: <YNQ0O0vhtpStp0n/@hovoldconsulting.com> (Johan Hovold's message
        of "Thu, 24 Jun 2021 09:28:59 +0200")
Message-ID: <87tulnms3o.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.2 at canardo
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Hovold <johan@kernel.org> writes:

> Could you please also post the output of usb-devices (or lsusb -v) for
> this device in MBIM mode?

Yes, this would be nice to have.

I suspect that this device is like other SDX55 devices we've seen, using
class/subclass/function to map the vendor specific functions
too. Dropping static interface numbers.  If correct, then the patch is
bogus and the interface numbers might change based on firmware version
and configuration.


Bj=C3=B8rn
