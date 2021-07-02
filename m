Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A933BA0CD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 14:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhGBNB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 09:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbhGBNB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 09:01:57 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AFDC061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 05:59:24 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o22so6642017wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 05:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kZuiFDeOIOBYifCX3ETY7kwldfmbcpuoWHSB8pBYdKE=;
        b=Re9YmD2ClDVWOLgAqgPP7hn8GwJbxI/ZcjG80VUMuTBKM5GqgABebTkDvoGoY5r32m
         2unOB0WV+NOAYpm0eaLntchrtHBfABQZAq51/RZ1wDVOyeDK2HZRAcX5nmA2aC/SD778
         yYBzge0xIMdtb2mZrsugKqXSjUeP95CjU5PKIEy9Iae3RlXMYCisKztJ+GaPKpq5q9uC
         Dl+aKHCV5fsi6EYE/M8SMq9KmQ+M1BPefyWuVDYJTXDQ1qDvz0y9aqN0zqnG4I+Xn39E
         ijPdDsenmiL5fm5gLjASqJu3mPkYnoVY/3Zen6CGshtT88fYers6Xiklqesy8XLqzxjD
         igGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kZuiFDeOIOBYifCX3ETY7kwldfmbcpuoWHSB8pBYdKE=;
        b=oJ0xJpJ4xaIl33iNcNVPtX7o42CrlDM3dbxKmi0T56mEnKoCbZ1QAgOZRqAKEHO7PX
         elCbmLjYlSsdoqkE2GZ0kAQhgCEIxFx6sDEEPkqfrYKOuJlnsPhqzaCGyhZatukdpQJf
         lA+hr3O2xejVYSoJORZlbNYgpgJWGBLsxgOLjzB8cG9kYnuCPVlEbWO5Tb/zwvAeG52n
         +422vWM5YGc7PkYlhuI2H8fUC/neY7bMAH1PLZP+Oefct18FbSbznuv8JXP0nQVlwrgc
         HzHlYhE7i4oDQsSFmeWPLHN7mSeN3eSZ2Wdr1RnkWHCr1fTg6QGFhbGSJJGHObmJ4lZE
         vtnw==
X-Gm-Message-State: AOAM530s/EiqUc+1VjCU3hyd5oqXtkCeICODY9W1+zc+XVxgH5nIfkNu
        zJkiw9ECeujP9RJs5i+mcDj6Wg==
X-Google-Smtp-Source: ABdhPJy/rCwOyJgulhr7LyEtiOliVGjrGMRhcIWWWC1nFIFsFaZOIGpvInl3sLt+dus1zmsnqwQf2g==
X-Received: by 2002:a1c:2985:: with SMTP id p127mr5348312wmp.165.1625230763025;
        Fri, 02 Jul 2021 05:59:23 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id s5sm3229780wrn.38.2021.07.02.05.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 05:59:22 -0700 (PDT)
Date:   Fri, 2 Jul 2021 13:59:20 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Yunus Bas <Y.Bas@phytec.de>
Cc:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "stwiss.opensource@diasemi.com" <stwiss.opensource@diasemi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: mfd-core: Change "Failed to locate of_node" warning
 to debug
Message-ID: <20210702125920.fydyfhwqe7tyr7oi@maple.lan>
References: <20210616081949.26618-1-y.bas@phytec.de>
 <YMm+VXRrRKIHGgmr@dell>
 <5a3f5fd82a391ade9a659338983e5efa7924210d.camel@phytec.de>
 <YMsHXEP36Vxr7lAb@dell>
 <03cb3befabdda032b1ec9d97b4daac69fa23c759.camel@phytec.de>
 <YNsid9K4PdUJbKqs@dell>
 <5a718e7812f2ce46347ae94fda6175f38c65359e.camel@phytec.de>
 <20210630105557.eaktwdz5p6yzuron@maple.lan>
 <YNxktsFmlzLcn4+Y@dell>
 <9b5d0003cce92cad57e7712d1e46c78c10f1a0ab.camel@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b5d0003cce92cad57e7712d1e46c78c10f1a0ab.camel@phytec.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2021 at 03:34:43PM +0000, Yunus Bas wrote:
> Am Mittwoch, dem 30.06.2021 um 13:33 +0100 schrieb Lee Jones:
> > On Wed, 30 Jun 2021, Daniel Thompson wrote:
> > 
> > > On Wed, Jun 30, 2021 at 07:27:32AM +0000, Yunus Bas wrote:
> > > > Am Dienstag, dem 29.06.2021 um 14:39 +0100 schrieb Lee Jones:
> > > > Imagine only required parts of the MFD is connected to the
> > > > designed
> > > > system and unrequired parts are not. In that case, fully
> > > > describing the
> > > > MFD in the devicetree wouldn't represent the system at all.
> > > 
> > > To describe hardware that is present but unused we would normally
> > > use
> > > status = "disabled".
> > > 
> > > So if, for example, your board cannot use the RTC for some reason
> > > (perhaps the board has no 32KHz oscillator?) then the DA9062 still
> > > contains the hardware but it is useless. Such hardware could be
> > > described as:
> > > 
> > > da9062_rtc: rtc {
> > >     compatible = "dlg,da9062-rtc";
> > >     status = "disabled";
> > > }
> > > 
> > > Is this sufficient to suppress the warnings when the hardware is
> > > not fully described?
<snip>
> > 
> > Right.  This is a potential solution.
> 
> @Daniel, you hit the nail on the head :). Thank you for that.
> 
> This solution would indeed surpress the warnings, but what is the
> benefit of this? We would define never used device nodes just to
> satisfy the driver.

I would say that doing so resolves an awkward ambiguity of
interpretation w.r.t. the bindings.

1. The MFD device compatible "dlg,da9062" tells the OS that we
   have an DA9062. An DA9062 contains six functions and this can be
   inferred *entirely* from the MFD compatible string. We do not
   need any subnodes to tell us that a DA9062 contains an RTC. The OS
   can (and in this case, does) already know that there is an RTC
   because we have a DA9062 (and a datasheet).

2. The default behaviour when a node has no status field is to
   assume that is is *enabled*.

Based on #1 and #2 above then assuming that a DT that omits the
sub-nodes actually means "disable the RTC" is risky. #2 might
actually make it more natural to assume that the device is present and
functional because there is no status field to tell MFD *not* to
initialize it.

That leaves us in a situation where there is no way to correctly guess
the authors intent when sub-nodes are omitted from the DT. Given this is
something of a corner case and the documentation is ambiguous then a
warning of the author does not clearly resolve the ambiguity seems
reasonable.


Daniel.
