Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091D03DF5C3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 21:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240051AbhHCTft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 15:35:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239633AbhHCTft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 15:35:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99E05600CD;
        Tue,  3 Aug 2021 19:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628019337;
        bh=3LHJk7B2hsn4dZXIOBfzYt5UUIb9qKQW2R3arUJBZjc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S6j2/bQKi7Fhh9Z/rwOmVr+D2plJM9YQsYAJw80zNoPpqrZ6IeL4X1eBEyIX4ESsv
         ktcEdoErkI/w6G5BmKg2wLehcl9vKq08gPSXxaLMXAGp2jWQO8ytkdC9h/DsSI8J8Q
         zxENNqIMa8nHM+Atjwxcr3fKZZ9glS7ns3wzXiWiDZQMZsk2/KpDdNuScGeWdGcfai
         FZECOD/LaygvTmjkQrBKJ05Tg/XN1cRmsbwLERBdMc0NFQ1cHTZKyYPTkuRLKFCVAm
         m46iPZ0os9JjWDVWO6WRWdylKXd2Q8XXkAtWqXEoAr68kiYCyzjRVuN5NkHMJ6iUSk
         sYLF6LKfmWw/g==
Received: by mail-ed1-f50.google.com with SMTP id k9so483458edr.10;
        Tue, 03 Aug 2021 12:35:37 -0700 (PDT)
X-Gm-Message-State: AOAM5319B5JbH5kAFh1lU9Qz9oPlCd63OtoM7uj6A3YG8kuH7PMbBVbj
        hH0Opyg4sc0KMvOtECRZPZXvP0KuiA6wEnm09w==
X-Google-Smtp-Source: ABdhPJxbon+wZW6OBJjn4JOOghwz+0MpFPYSpnbjTt0ZxOHvdCmbCuGVJbVzQLr3vOEhU7nEcp0bjVtIJr++VYfJeZE=
X-Received: by 2002:a05:6402:254a:: with SMTP id l10mr28248255edb.258.1628019336226;
 Tue, 03 Aug 2021 12:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210730061832.1927936-1-kyletso@google.com> <20210730061832.1927936-2-kyletso@google.com>
 <68732310-d53a-a86b-f43c-2ceb22051338@roeck-us.net> <YQmZ9/ytzOHoSaN3@robh.at.kernel.org>
In-Reply-To: <YQmZ9/ytzOHoSaN3@robh.at.kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 3 Aug 2021 13:35:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKn3e7_8Wb_qoXjBcu-GavK=7wZW59Y-i1SF9ORmmA6wQ@mail.gmail.com>
Message-ID: <CAL_JsqKn3e7_8Wb_qoXjBcu-GavK=7wZW59Y-i1SF9ORmmA6wQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: connector: Add pd-supported property
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Kyle Tso <kyletso@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 1:33 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Jul 29, 2021 at 11:29:06PM -0700, Guenter Roeck wrote:
> > On 7/29/21 11:18 PM, Kyle Tso wrote:
> > > Set "pd-unsupported" property if the Type-C connector has no power
> > > delivery support.
> > >
> >
> > subject is still wrong (it says pd-supported).
>
> And the commit msg too.

Err, sorry, it's the cover letter that's wrong.

Rob
