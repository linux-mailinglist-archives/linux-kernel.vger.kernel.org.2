Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CD93A3822
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 01:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhFJX6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 19:58:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhFJX6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 19:58:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCFA6610A5;
        Thu, 10 Jun 2021 23:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623369397;
        bh=bDhA1fKRiDxkl9TXszQ1UGz5jZvyWoozcIcwZ3sMLDU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y9JJyS0rglaO+usq21SPcy/gm6QRN8R2O+MM/4tMHr6XCEOK5dQWCHPc2DsvJ6I12
         RIF9noWVWsLEaViagg6kkQ1pI0KHvXNCRYE5AeSA7bENTfLgaD6rFYUP/KkAcD7Pdc
         rTzfcSeaCwiUWwiEhAI/k8qjbktP4VYY6ojQszxZO9bYxcBh5pZ8h+J+Fm2gW9AYXU
         PTYUjanlJxWtNk27u3plwSrftgCEnMBx6OIj+1IMaRBEAOKWlVKvwI/r3tJ/rHg9G0
         G9o+4XnVZiOaRVzln5yBTyUpKt11cW0ofvzgWh2YYS8MbZlJTpgKJ4plmjMuCpsLih
         yjISr3K/F8ITg==
Date:   Fri, 11 Jun 2021 08:56:35 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Devin Moore <devinmoore@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4 0/6] bootconfig: Add mixed subkeys and value under
 the same key
Message-Id: <20210611085635.f1655f08b7d8abc009776b6b@kernel.org>
In-Reply-To: <20210610123852.606aa3a4@oasis.local.home>
References: <162262192121.264090.6540508908529705156.stgit@devnote2>
        <CAOELnJzW4boH=WadqW31hbWLhmZgNLD9+EiN0GJGBe1RCMxFaw@mail.gmail.com>
        <20210610234809.9d1e92cb3f04842e14c3d011@kernel.org>
        <20210610122607.3817da31@oasis.local.home>
        <20210610123852.606aa3a4@oasis.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Fri__11_Jun_2021_08_56_35_+0900_+UgJWd=vYGdT+59Q"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Fri__11_Jun_2021_08_56_35_+0900_+UgJWd=vYGdT+59Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jun 2021 12:38:52 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 10 Jun 2021 12:26:07 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > I should set up a ktest config file that reads each of the example
> > bootconfigs, and boots the kernel, and checks that each of them took
> > affect without doing any other side effects.

Thanks for adding bootconfig to the ktest!

> > 
> > I'll work to create a ktest config sample to test them, and send them
> > out.
> 
> The sample configs seem to be just that, samples, and not something
> that I can just load.
> 
> Do you have a set of bootconfig scripts I could use to load and boot
> the kernel and make sure that they did what they intended to do?

Yes, I have some example scripts. But maybe smaller example will be
better for test?
Let me break those example so that you can easily test that.

Also, you can find some syntax examples under tools/bootconfig/samples/.
(But I think those are already tested by bootconfig command anyway)

> 
> Then I can make a series of ktest tests to test each one.
> 
> In the mean time, I'll just push out the branch to linux-next.

Thank you!

> 
> Thanks!
> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>

--Multipart=_Fri__11_Jun_2021_08_56_35_+0900_+UgJWd=vYGdT+59Q
Content-Type: application/octet-stream;
 name="boottrace.bconf"
Content-Disposition: attachment;
 filename="boottrace.bconf"
Content-Transfer-Encoding: base64

ZnRyYWNlLmV2ZW50IHsKCXRhc2sudGFza19uZXd0YXNrIHsKCQlmaWx0ZXIgPSAicGlkIDwgMTI4
IgoJCWVuYWJsZQoJfQoJa3Byb2Jlcy52ZnNfcmVhZCB7CiAgICAgICAgICAgICAgcHJvYmVzID0g
InZmc19yZWFkICRhcmcxICRhcmcyIgogICAgICAgICAgICAgIGZpbHRlciA9ICJjb21tb25fcGlk
IDwgMjAwIgogICAgICAgICAgICAgIGVuYWJsZQogICAgICB9CiAgICAgIHN5bnRoZXRpYy5pbml0
Y2FsbF9sYXRlbmN5IHsKICAgICAgICAgICAgICBmaWVsZHMgPSAidW5zaWduZWQgbG9uZyBmdW5j
IiwgInU2NCBsYXQiCiAgICAgICAgICAgICAgYWN0aW9ucyA9ICJoaXN0OmtleXM9ZnVuYy5zeW0s
bGF0OnZhbHM9bGF0OnNvcnQ9bGF0IgogICAgICB9CiAgICAgIGluaXRjYWxsLmluaXRjYWxsX3N0
YXJ0IHsKICAgICAgICAgICAgICBhY3Rpb25zID0gImhpc3Q6a2V5cz1mdW5jOnRzMD1jb21tb25f
dGltZXN0YW1wLnVzZWNzIgogICAgICB9CiAgICAgIGluaXRjYWxsLmluaXRjYWxsX2ZpbmlzaCB7
CiAgICAgICAgICAgICAgYWN0aW9ucyA9ICJoaXN0OmtleXM9ZnVuYzpsYXQ9Y29tbW9uX3RpbWVz
dGFtcC51c2Vjcy0kdHMwOm9ubWF0Y2goaW5pdGNhbGwuaW5pdGNhbGxfc3RhcnQpLmluaXRjYWxs
X2xhdGVuY3koZnVuYywkbGF0KSIKICAgICAgfQp9CgpmdHJhY2UuaW5zdGFuY2UgewogICAgICBm
b28gewogICAgICAgICAgICAgIHRyYWNlciA9ICJmdW5jdGlvbiIKICAgICAgICAgICAgICBmdHJh
Y2UuZmlsdGVycyA9ICJ1c2VyXyoiCiAgICAgICAgICAgICAgY3B1bWFzayA9IDEKICAgICAgICAg
ICAgICBvcHRpb25zID0gbm9zeW0tYWRkcgogICAgICAgICAgICAgIGJ1ZmZlcl9zaXplID0gNTEy
S0IKICAgICAgICAgICAgICB0cmFjZV9jbG9jayA9IG1vbm8KCQlldmVudC5zaWduYWwuc2lnbmFs
X2RlbGl2ZXIuYWN0aW9ucz1zbmFwc2hvdAogICAgICB9CiAgICAgIGJhciB7CiAgICAgICAgICAg
ICAgdHJhY2VyID0gImZ1bmN0aW9uIgogICAgICAgICAgICAgIGZ0cmFjZS5maWx0ZXJzID0gImtl
cm5lbF8qIgoJICAgICAgY3B1bWFzayA9IDIKICAgICAgICAgICAgIHRyYWNlX2Nsb2NrID0geDg2
LXRzYwogICAgICB9Cn0KCmZ0cmFjZS5hbGxvY19zbmFwc2hvdAoKa2VybmVsIHsKICAgICAgdHJh
Y2Vfb3B0aW9ucyA9IHN5bS1hZGRyCiAgICAgIHRyYWNlX2V2ZW50cyA9ICJpbml0Y2FsbDoqIgoj
ICAgICAgdHBfcHJpbnRrCiAgICAgIHRyYWNlX2J1Zl9zaXplID0gMU0KICAgICAgZnRyYWNlID0g
ZnVuY3Rpb24KICAgICAgZnRyYWNlX2ZpbHRlciA9ICJ2ZnMqIgp9Cg==

--Multipart=_Fri__11_Jun_2021_08_56_35_+0900_+UgJWd=vYGdT+59Q
Content-Type: application/octet-stream;
 name="tracing.bconf"
Content-Disposition: attachment;
 filename="tracing.bconf"
Content-Transfer-Encoding: base64

ZnRyYWNlIHsKCXRyYWNlciA9IGZ1bmN0aW9uOwoJb3B0aW9ucyA9IGV2ZW50LWZvcmssIHN5bS1h
ZGRyLCBzdGFja3RyYWNlOwoJYnVmZmVyX3NpemUgPSAxTTsKCWFsbG9jX3NuYXBzaG90OwoJdHJh
Y2VfY2xvY2sgPSBnbG9iYWw7CglldmVudHMgPSAidGFzazp0YXNrX25ld3Rhc2siLCAiaW5pdGNh
bGw6KiI7CglldmVudC5zY2hlZC5zY2hlZF9wcm9jZXNzX2V4ZWMgewoJCWZpbHRlciA9ICJwaWQg
PCAxMjgiOwoJfQoJZXZlbnQua3Byb2Jlcy5teWV2ZW50IHsKCQlwcm9iZXMgPSAidmZzX3JlYWQg
JGFyZzEgJGFyZzIiLCAidmZzX3dyaXRlICRhcmcxICRhcmcyIgoJfQoJZXZlbnQua3Byb2Jlcy5t
eWV2ZW50MiB7CgkJcHJvYmVzID0gImluaXRyZF9sb2FkIjsKCX0KCWV2ZW50Lmtwcm9iZXMuZW5h
YmxlCglpbnN0YW5jZS5iYXIgewoJCWV2ZW50LnN5bnRoZXRpYy5pbml0Y2FsbF9sYXRlbmN5IHsK
CQkJZmllbGRzID0gInVuc2lnbmVkIGxvbmcgZnVuYyIsICJ1NjQgbGF0IjsKCQkJYWN0aW9ucy5o
aXN0IHsKCQkJCWtleXMgPSBmdW5jLnN5bSwgbGF0OwoJCQkJdmFscyA9IGxhdDsKCQkJCXNvcnQg
PSBsYXQ7CgkJCX0KCQl9CgkJZXZlbnQuaW5pdGNhbGwgewoJCQlpbml0Y2FsbF9zdGFydC5hY3Rp
b25zLmhpc3QgewoJCQkJa2V5cyA9IGZ1bmM7CgkJCQl0czAgPSAiY29tbW9uX3RpbWVzdGFtcC51
c2VjcyI7CgkJCX0KCQkJaW5pdGNhbGxfZmluaXNoLmFjdGlvbnMuaGlzdCB7CgkJCQlrZXlzID0g
ImZ1bmMiOwoJCQkJbGF0ID0gImNvbW1vbl90aW1lc3RhbXAudXNlY3MtJHRzMCI7CgkJCQlvbm1h
dGNoID0gImluaXRjYWxsLmluaXRjYWxsX3N0YXJ0IiwKCQkJCQkgICJpbml0Y2FsbF9sYXRlbmN5
KGZ1bmMsJGxhdCkiOwoJCQl9CgkJfQoJfQoJaW5zdGFuY2UuZm9vIHsKCQl0cmFjZXIgPSBmdW5j
dGlvbi1ncmFwaDsKCQl0cmFjaW5nX29uID0gZmFsc2U7CgkJZXZlbnQud29ya3F1ZXVlLndvcmtx
dWV1ZV9zdGFydC5hY3Rpb25zID0gInRyYWNpbmdfb24iOwoJCWV2ZW50LndvcmtxdWV1ZS53b3Jr
cXVldWVfZW5kLmFjdGlvbnMgPSAidHJhY2luZ19vZmYiOwoJfTsKfQprZXJuZWwgewoJdHBfcHJp
bnRrOwoJZHVtcF9vbl9vb3BzID0gMgoJdHJhY2VvZmZfb25fd2FybmluZwp9Cg==

--Multipart=_Fri__11_Jun_2021_08_56_35_+0900_+UgJWd=vYGdT+59Q
Content-Type: application/octet-stream;
 name="functiongraph.bconf"
Content-Disposition: attachment;
 filename="functiongraph.bconf"
Content-Transfer-Encoding: base64

ZnRyYWNlIHsKICAgICAgdHJhY2luZ19vbiA9IDAgICMgb2ZmIGJ5IGRlZmF1bHQKICAgICAgdHJh
Y2VyID0gZnVuY3Rpb25fZ3JhcGgKICAgICAgZXZlbnQua3Byb2JlcyB7CiAgICAgICAgICAgICAg
ICBzdGFydF9ldmVudCB7CiAgICAgICAgICAgICAgICAgICAgICAgIHByb2JlcyA9ICJwY2lfcHJv
Y19pbml0IgogICAgICAgICAgICAgICAgICAgICAgICBhY3Rpb25zID0gInRyYWNlb24iCiAgICAg
ICAgICAgICAgICB9CiAgICAgICAgICAgICAgICBlbmRfZXZlbnQgewogICAgICAgICAgICAgICAg
ICAgICAgICBwcm9iZXMgPSAicGNpX3Byb2NfaW5pdCVyZXR1cm4iCiAgICAgICAgICAgICAgICAg
ICAgICAgIGFjdGlvbnMgPSAidHJhY2VvZmYiCiAgICAgICAgICAgICAgICB9CiAgICAgICAgfQog
IH0KCg==

--Multipart=_Fri__11_Jun_2021_08_56_35_+0900_+UgJWd=vYGdT+59Q
Content-Type: application/octet-stream;
 name="ftrace.bconf"
Content-Disposition: attachment;
 filename="ftrace.bconf"
Content-Transfer-Encoding: base64

IyEvYmluL3NoCgpmdHJhY2UgewoJb3B0aW9ucyA9ICJzeW0tYWRkciIsICJjb250ZXh0LWluZm8i
CglidWZmZXJfc2l6ZSA9IDFNQgp9CgpmdHJhY2UuZXZlbnQgewoJIyBTYW1wbGUxOiBNYWtlIGEg
aGlzdG9ncmFtIGZvciBpbml0Y2FsbCBmdW5jdGlvbnMKCXN5bnRoZXRpYy5pbml0Y2FsbF9sYXRl
bmN5IHsKICAgICAgICAgICAgICAgIGZpZWxkcyA9ICJ1bnNpZ25lZCBsb25nIGZ1bmMiLCAidTY0
IGxhdCIKCQloaXN0IHsKCQkJa2V5cyA9IGZ1bmMuc3ltLCBsYXQKCQkJdmFscyA9IGxhdAoJCQlz
b3J0ID0gbGF0CgkJfQoJfQoJaW5pdGNhbGwuaW5pdGNhbGxfc3RhcnQuaGlzdCB7CgkJa2V5cyA9
IGZ1bmMKCQl2YXIudHMwID0gY29tbW9uX3RpbWVzdGFtcC51c2VjcwoJfQoJaW5pdGNhbGwuaW5p
dGNhbGxfZmluaXNoLmhpc3QgewoJCWtleXMgPSBmdW5jCgkJdmFyLmxhdCA9IGNvbW1vbl90aW1l
c3RhbXAudXNlY3MgLSAkdHMwCgkJb25tYXRjaCB7CgkJCWV2ZW50ID0gaW5pdGNhbGwuaW5pdGNh
bGxfc3RhcnQKCQkJYWN0aW9uID0gImluaXRjYWxsX2xhdGVuY3koZnVuYywgJGxhdCkiCgkJfQoJ
fQoKCSMgU2FtcGxlMjoga21hbGxvYygpIHRyYWNpbmcgaW4gcmVhZCgyKSBzeXNjYWxsCglzeXNj
YWxscy5zeXNfZW50ZXJfcmVhZC5lbmFibGVfZXZlbnQgewoJCWV2ZW50ID0ga21lbS5rbWFsbG9j
CgkJY291bnQgPSAxCgl9CglzeXNjYWxscy5zeXNfZXhpdF9yZWFkLmRpc2FibGVfZXZlbnQgewoJ
CWV2ZW50ID0ga21lbS5rbWFsbG9jCgl9CgoJIyBTYW1wbGUzOiBTdGFja3RyYWNlIGF0IHRoZSBl
dmVudAoJa21lbS5rbWFsbG9jLnN0YWNrdHJhY2UgewoJCWNvdW50ID0gNQoJCWZpbHRlciA9ICdi
eXRlc19yZXEgPj0gNjU1MzYnCgl9CgoJIyBTYW1wbGU0OiBUYWtlIGEgc25hcHNob3QKCWJsb2Nr
LmJsb2NrX3VucGx1Zy5zbmFwc2hvdCB7CgkJY291bnQgPSAxCgkJZmlsdGVyID0gbnJfcnEgPiAx
Cgl9CgoJIyBTYW1wbGU1OiBUcmFjZS1vbi9vZmYKCWJsb2NrLmJsb2NrX3BsdWcudHJhY2VvbiB7
CgkJZmlsdGVyID0gbnJfcnEgPiAxCgl9CglibG9jay5ibG9ja191bnBsdWcudHJhY2VvZmYgewoJ
CWZpbHRlciA9IG5yX3JxID4gMQoJfQoKICAgICAgICAjIFNhbXBsZTY6IG9ubWF4CglzY2hlZC5z
Y2hlZF93YWtpbmcgewoJCWVuYWJsZQoJCWhpc3QgewoJCQlrZXlzID0gcGlkCgkJCXRzMSA9IGNv
bW1vbl90aW1lc3RhbXAudXNlY3MKCQkJZmlsdGVyID0gJ2NvbW0gPT0gImN5Y2xpY3Rlc3QiJwoJ
CX0KCX0KCXNjaGVkLnNjaGVkX3N3aXRjaCB7CgkJZW5hYmxlCgkJaGlzdCB7CgkJCWtleXMgPSBu
ZXh0X3BpZAoJCQl2YXIud2FrZXVwX2xhdCA9IGNvbW1vbl90aW1lc3RhbXAudXNlY3MgLSAkdHMx
CgkJCW9ubWF4IHsKCQkJCXZhciA9IHdha2V1cF9sYXQKCQkJCWFjdGlvbiA9ICJzYXZlKG5leHRf
cHJpbyxuZXh0X2NvbW0scHJldl9waWQscHJldl9wcmlvLHByZXZfY29tbSkiCgkJCX0KCQkJZmls
dGVyID0gJ25leHRfY29tbSA9PSAiY3ljbGljdGVzdCInCgkJfQoJfQp9Cgo=

--Multipart=_Fri__11_Jun_2021_08_56_35_+0900_+UgJWd=vYGdT+59Q--
