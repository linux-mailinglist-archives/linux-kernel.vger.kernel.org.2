Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAE3416269
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 17:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242145AbhIWPvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 11:51:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242172AbhIWPuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:50:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4853B6008E;
        Thu, 23 Sep 2021 15:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632412124;
        bh=FI+LxKsIIc2jqDmoLIF3HH4uGPkcIv4DllCKMTlM1lA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=YrAL3rtByebZdH0B+5sxM2xIMXgYEkp8WRfTrIyZBbIHYt5FSnhvbEO5vzNCj6Mwl
         0gmUX6PfilnDPVtJnbcWIZxGM6q3PMhNXWwH2IfHsVK9QozPiQO/AajcR90nH8jkwu
         1lRoy1MX3bs6mLq0z83hDSbsYifaXNgGJwQB1QbOaGDaRUbVXZ7fYMmQHLhkiUuZBo
         12Z5+daWlV/5E+9WLmdoxXbGELDQBoRnsnfExXr97G1XXVqoLxxK7e/L/vPyPY5iAk
         5GiFytYxShi2LlFWOaxkpWZ3RnBD/W4aEZpg0S8uKcyIRGmLoaZMxOYTSj+nJOplY/
         QzmjIsrPlOvjQ==
Date:   Thu, 23 Sep 2021 08:48:43 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "julien@xen.org" <julien@xen.org>,
        "jbeulich@suse.com" <jbeulich@suse.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [PATCH 2/2] xen-pciback: prepare for the split for stub and PV
In-Reply-To: <98e432f0-6be1-6394-1c06-ac5e726c708d@epam.com>
Message-ID: <alpine.DEB.2.21.2109230848290.17979@sstabellini-ThinkPad-T480s>
References: <20210922101422.2319240-1-andr2000@gmail.com> <20210922101422.2319240-2-andr2000@gmail.com> <alpine.DEB.2.21.2109221407350.17979@sstabellini-ThinkPad-T480s> <4552e4b6-21a8-4829-16b4-7cda8ba0c0d1@epam.com> <7880dee9-7372-5a25-db55-018f21e8b08c@suse.com>
 <98e432f0-6be1-6394-1c06-ac5e726c708d@epam.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1873022447-1632412124=:17979"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1873022447-1632412124=:17979
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 23 Sep 2021, Oleksandr Andrushchenko wrote:
> On 23.09.21 12:05, Juergen Gross wrote:
> > On 23.09.21 11:02, Oleksandr Andrushchenko wrote:
> >>
> >> On 23.09.21 00:10, Stefano Stabellini wrote:
> >>> On Wed, 22 Sep 2021, Oleksandr Andrushchenko wrote:
> >>>> --- a/drivers/xen/xen-pciback/xenbus.c
> >>>> +++ b/drivers/xen/xen-pciback/xenbus.c
> >>>> @@ -743,6 +743,9 @@ const struct xen_pcibk_backend *__read_mostly xen_pcibk_backend;
> >>>>       int __init xen_pcibk_xenbus_register(void)
> >>>>    {
> >>>> +    if (!xen_pcibk_pv_support())
> >>>> +        return 0;
> >>> Is this truly enough to stop the PV backend from initializing? Have you
> >>> actually tested it to make sure? If it works, amazing! I am quite happy
> >>> about this approach :-)
> >>
> >> Well, I put some logs into the driver and saw nothing obvious pointing
> >>
> >> to any backend activities (probably this is also because I don't have any
> >>
> >> frontend). I see that the xenbus driver is not registered. In XenStore I see:
> >>
> >> root@dom0:~# xenstore-ls -f | grep pci
> >> /local/domain/0/backend/pci = ""
> >> /local/domain/0/backend/pci/2 = ""
> >> /local/domain/0/backend/pci/2/0 = ""
> >> /local/domain/0/backend/pci/2/0/frontend = "/local/domain/2/device/pci/0"
> >> /local/domain/0/backend/pci/2/0/frontend-id = "2"
> >> /local/domain/0/backend/pci/2/0/online = "1"
> >> /local/domain/0/backend/pci/2/0/state = "1"
> >> /local/domain/0/backend/pci/2/0/domain = "DomU"
> >> /local/domain/0/backend/pci/2/0/key-0 = "0000:03:00.0"
> >> /local/domain/0/backend/pci/2/0/dev-0 = "0000:03:00.0"
> >> /local/domain/0/backend/pci/2/0/opts-0 = "msitranslate=0,power_mgmt=0,permissive=0,rdm_policy=strict"
> >> /local/domain/0/backend/pci/2/0/state-0 = "1"
> >> /local/domain/0/backend/pci/2/0/num_devs = "1"
> >> /local/domain/2/device/pci = ""
> >> /local/domain/2/device/pci/0 = ""
> >> /local/domain/2/device/pci/0/backend = "/local/domain/0/backend/pci/2/0"
> >> /local/domain/2/device/pci/0/backend-id = "0"
> >> /local/domain/2/device/pci/0/state = "1"
> >> /libxl/pci = ""
> >> /libxl/pci/0000-03-00-0 = ""
> >> /libxl/pci/0000-03-00-0/domid = "2"
> >>
> >> But IIUIC these come from the toolstack
> >>
> >> @Juergen, do you know how to check if the backend is indeed not running
> >>
> >> or the above should be enough to prove?
> >
> > I don't see how the backend could be running without being registered
> > with xenbus. It won't receive any watches, so there is no way a
> > connection with a frontend could be established.
> 
> This is my understanding too, so the only change I've put in patch I removed
> 
> register/unregister. It seems this is just enough and the patch should be ok as is

Fantastic! Thanks for checking.
--8323329-1873022447-1632412124=:17979--
