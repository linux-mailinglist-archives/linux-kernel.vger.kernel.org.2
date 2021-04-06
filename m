Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F89355BF7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 21:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236926AbhDFTGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 15:06:01 -0400
Received: from mout.gmx.net ([212.227.17.22]:43883 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236040AbhDFTF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 15:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617735936;
        bh=S5w76roMR9069RbtJkgU377LovVfOK0MpWKmGi2/kjk=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=YUvW0IUkEYFFBjdbWiLopC7be2NB6xosmAvZqw1+MYNWduVNaDmlVPE4efPOEFkwJ
         Nn7C2tFhRSn52qW6QmPZUJ9ZzQK/kW7ZDno+mqxgg/oaQdYHIvffm1RQXYgoOvRoxv
         1PQEWcPZ4EvNmficarqQZgkIvIpDk81npdW3ebLM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.35] ([62.143.247.63]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWigq-1l5gHP3Qk4-00X3ZS; Tue, 06
 Apr 2021 21:05:35 +0200
To:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [RFC] dt-bindings: riscv: enum for riscv,isa
Message-ID: <5385012d-9f09-d7d9-7b6a-cef7de2d4056@gmx.de>
Date:   Tue, 6 Apr 2021 21:05:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ngX28VYtdWQlHye7iPLWOBYn1ApSoOWXfA3SALu5YrflY7O+Qr/
 fZpezTIa/Nlhrsrdk9Lo/Y398bJ1h7tVl9oaPRkKRR+kMZWYWn3i+aFDp4GXpDdFXSeYAO2
 ItcbGkvnpvqiJGS+nuHYiriX0p3XHuyUBtt8ChCTREYFCRTkLqB4aTiXu/0VqJCWib9iOs6
 TkJj2Kcj5ofZ+TLHIVrxw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UepjL+PZHsc=:BanShc5P6UyNbjSNcxkUNf
 zFYy/wDiOrK+rPwaV2rT1KnHpgwY2GVujT30j25QUW5YoobHI9kwgoTm+Gf7S/7bFc/6W1qDi
 p9AA6ZZnhQLeBWiJAaXE2FVMbUFsS+QfX2nCmYqzAWFl14OAFNvCtytuHS2TBklMymnESTpnb
 NuJ2kcsXtuhkgCCyamft7+66Kc0q1R4rJ/6dKr5L6LQhqJrI6kPC3r/cpzDrDkAzo7XZrl2mC
 XDACxBqFk3dUIgkqys4w4gRTg9iJiPn87JTR25jjwUVxAc8yUoi/6r5d6TutyuDuFMBMB2/Le
 R6jrnuXCrNwp23PRH7fS3tV8DGFmjLhTICvp+P2BZ2LLq3hVNc8Y3fZvM2PJXfo63tUFBSzXF
 V4wVsB2k/FuTjNE9vyg4UzvUMuArWX3VlR/Zj5/HKlRCjgCSkTMZCRSi/bvvfhpRcMbcXqM/3
 xFfXqHufV6iP+zYG12jZoUtVHwqE7k1LwdzLJ8reufc9en3BZr0LFbDBwYUWj0ndBT5RBA85H
 W99GkXuklomm8hH5zwC8jG5bpL9r2CscvZFcN9PUKzKBKKlSZwXUla7PGgNqwYYvQaaAWYcZ4
 uGWyOX5I2OyfLv0rgeAHmr0DoEMgp4AfjDLgJuboZiEpdtCTTMd8K+WpKcPkfeB0xhAFQD2kU
 6O5IdeziwXrF9jVOktLRrabwTTUjr/u1K+0r5jGS1MIG2EVepDyldXGJzEchxt61hB9LBOWBR
 W91WKo92D4j5xjtPJzDmLRjtqcy4phKeQFmFUhwP9nIddAw3tgfq/+X1CYbOhj+2KuVFkbhui
 ruA4rbBWdULlNWmdYObMKIIDJRzvbUIShr8azks5hkzBsNVFviSAfnGffTcXUOf7GajM6U9bi
 mUFJqGTvfArPoTsINPOFAMNLOtH7WCf81z8Jc79Q7EocxQJRSLlyyEwZUcypJbN3gRYu7nsW+
 QPm+go/7A74UFcHZiliARwGqkoItSzSLGVm+ngzqzMFDpTbuuttKzkTZ8hHxm93GzuRYZFviL
 2ZXegoYj0QuxhdruAF+Vrq2LgQ1qGU8m7YewqD6jkMdouN2fD+sNRCRjYDp+8wr01icY6Hfb6
 egGyQp63KAgHQ3GDzB+xj8mMg0RboqmGikpRuIHdE+xtHrzJaK4z/I3i7F8n0YwcREY+mlyVI
 1DFqbCQau0bxor+CmuQT1lQ/UCniF8wDt4xYlbqquPyEwr8aNaWLOWxZfDFd7PR4g1Cng=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Documentation/devicetree/bindings/riscv/cpus.yaml I find for riscv,isa:

     enum:
       - rv64imac
       - rv64imafdc

This implies that 'rv64imafc' or 'rv64imafdqc' would be illegal values
while these combinations of extensions would be compliant with "The
RISC-V Instruction Set Manual".

To me it does not make much sense to try to enumerate all permissible
permutations of RISC-V extensions.

Shouldn't this enum be removed and replaced by examples?

Best regards

Heinrich
