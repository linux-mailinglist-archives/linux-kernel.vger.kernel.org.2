Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A06B3D3100
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 02:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbhGWADK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 20:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbhGWACL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 20:02:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07DFC061760
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 17:42:39 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so619592wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 17:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vIfpi2vvYk5ekLWLauv6LqxEtmMlzvwiRb8OJVQ8Wkg=;
        b=JvsSx8+Q86sqpcLcK8UdI3Vbqx94Tzu0VQF/CTt0vbZqbi60kkhU31KBxDYBWv8Mo2
         FdKoC1priA3euryNBszGvgUXf0LBMDaAGqeevrZsr0PDixKgBMCIUcYZOqnw/DAtuNNV
         ypXGpsfZQ6EXwJIoSsIueLzd5ioDvR5pod3Ysu/R1tkoAAToSL5fgeFADr8xVFoNXweW
         fvR6isEpy0OoHYWg2yqBONnSaYFywyyj1QLkorfpPajzjJMSzNR5KVyNph0zfvsnent5
         3fxFlvspx2exY8Nc1K9KeDjocb6i12rzyNvZP75sUV7A1m9eLtnP8HmjNl8tvBcuHrz0
         Kbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vIfpi2vvYk5ekLWLauv6LqxEtmMlzvwiRb8OJVQ8Wkg=;
        b=WIc5vCSt6wvcTKmyBTUfZ+HwvpW3UHC8wOg8x9w52bvmXAXsgr3gAKU9N3A6qfzDzt
         bQ+/PxkSfH6LBMQv5oLPN/9SYfL8pfNQRaB/DnqqDWfVwgULYDfXxtf4f0z4L+5FS/lJ
         nJPwZBUdcm+GTvsVlf3vPYLEBdXOohk7AOHwWwcozKv5Lc3fuz07LNtQSpq9PJ1Xq8we
         tWBqU7yrBjz6pkUQfhBiZ4hrzReYm3fJzAgVBcszU1LgbvyznSrmkQWllT/dQj///DfN
         XQUgu+EQxdXoWUnLr/iVkPYdPYSGpsCjta60qECH7CkgNn49Cg/1iozRgrhxEcDoHVg1
         6fIQ==
X-Gm-Message-State: AOAM531MR83HbuyQ4GfZ3AaZ3aMYVwlWVWBKfLk9oYVmVdyTFKY2RSDc
        TF674jSt7/JGUyUV8iWyKkel6A==
X-Google-Smtp-Source: ABdhPJyIzI4vPjqylideFPk5QblBTdmzPQ/RSHy0ufGS+MwK1u/F3kS5I6hiSfCP4oEE6Eh86T5gWQ==
X-Received: by 2002:a7b:cbd5:: with SMTP id n21mr11726539wmi.2.1627000958312;
        Thu, 22 Jul 2021 17:42:38 -0700 (PDT)
Received: from localhost.localdomain (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id m4sm31630498wrs.14.2021.07.22.17.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 17:42:37 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        fabioaiuto83@gmail.com
Subject: [PATCH 6/7] staging: rtl8188eu: introduce new supporting files for RTL8188eu driver
Date:   Fri, 23 Jul 2021 01:42:13 +0100
Message-Id: <20210723004214.912295-7-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210723004214.912295-1-phil@philpotter.co.uk>
References: <20210723004214.912295-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is split in order to keep the file sizes down. These
supporting files are part of the newer/better driver from GitHub modified by
Larry Finger. Import this as the basis for all future work going
forward. Also, modify Makefile so that driver has same module filename
as original rtl8188eu driver from staging.

Suggested-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/COPYING  | 356 ++++++++++++++++++++
 drivers/staging/rtl8188eu/Kconfig  |  25 ++
 drivers/staging/rtl8188eu/Makefile | 509 +++++++++++++++++++++++++++++
 3 files changed, 890 insertions(+)
 create mode 100644 drivers/staging/rtl8188eu/COPYING
 create mode 100644 drivers/staging/rtl8188eu/Kconfig
 create mode 100755 drivers/staging/rtl8188eu/Makefile

diff --git a/drivers/staging/rtl8188eu/COPYING b/drivers/staging/rtl8188eu/COPYING
new file mode 100644
index 000000000000..ca442d313d86
--- /dev/null
+++ b/drivers/staging/rtl8188eu/COPYING
@@ -0,0 +1,356 @@
+
+   NOTE! This copyright does *not* cover user programs that use kernel
+ services by normal system calls - this is merely considered normal use
+ of the kernel, and does *not* fall under the heading of "derived work".
+ Also note that the GPL below is copyrighted by the Free Software
+ Foundation, but the instance of code that it refers to (the Linux
+ kernel) is copyrighted by me and others who actually wrote it.
+
+ Also note that the only valid version of the GPL as far as the kernel
+ is concerned is _this_ particular version of the license (ie v2, not
+ v2.2 or v3.x or whatever), unless explicitly otherwise stated.
+
+			Linus Torvalds
+
+----------------------------------------
+
+		    GNU GENERAL PUBLIC LICENSE
+		       Version 2, June 1991
+
+ Copyright (C) 1989, 1991 Free Software Foundation, Inc.
+                       51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ Everyone is permitted to copy and distribute verbatim copies
+ of this license document, but changing it is not allowed.
+
+			    Preamble
+
+  The licenses for most software are designed to take away your
+freedom to share and change it.  By contrast, the GNU General Public
+License is intended to guarantee your freedom to share and change free
+software--to make sure the software is free for all its users.  This
+General Public License applies to most of the Free Software
+Foundation's software and to any other program whose authors commit to
+using it.  (Some other Free Software Foundation software is covered by
+the GNU Library General Public License instead.)  You can apply it to
+your programs, too.
+
+  When we speak of free software, we are referring to freedom, not
+price.  Our General Public Licenses are designed to make sure that you
+have the freedom to distribute copies of free software (and charge for
+this service if you wish), that you receive source code or can get it
+if you want it, that you can change the software or use pieces of it
+in new free programs; and that you know you can do these things.
+
+  To protect your rights, we need to make restrictions that forbid
+anyone to deny you these rights or to ask you to surrender the rights.
+These restrictions translate to certain responsibilities for you if you
+distribute copies of the software, or if you modify it.
+
+  For example, if you distribute copies of such a program, whether
+gratis or for a fee, you must give the recipients all the rights that
+you have.  You must make sure that they, too, receive or can get the
+source code.  And you must show them these terms so they know their
+rights.
+
+  We protect your rights with two steps: (1) copyright the software, and
+(2) offer you this license which gives you legal permission to copy,
+distribute and/or modify the software.
+
+  Also, for each author's protection and ours, we want to make certain
+that everyone understands that there is no warranty for this free
+software.  If the software is modified by someone else and passed on, we
+want its recipients to know that what they have is not the original, so
+that any problems introduced by others will not reflect on the original
+authors' reputations.
+
+  Finally, any free program is threatened constantly by software
+patents.  We wish to avoid the danger that redistributors of a free
+program will individually obtain patent licenses, in effect making the
+program proprietary.  To prevent this, we have made it clear that any
+patent must be licensed for everyone's free use or not licensed at all.
+
+  The precise terms and conditions for copying, distribution and
+modification follow.
+
+		    GNU GENERAL PUBLIC LICENSE
+   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
+
+  0. This License applies to any program or other work which contains
+a notice placed by the copyright holder saying it may be distributed
+under the terms of this General Public License.  The "Program", below,
+refers to any such program or work, and a "work based on the Program"
+means either the Program or any derivative work under copyright law:
+that is to say, a work containing the Program or a portion of it,
+either verbatim or with modifications and/or translated into another
+language.  (Hereinafter, translation is included without limitation in
+the term "modification".)  Each licensee is addressed as "you".
+
+Activities other than copying, distribution and modification are not
+covered by this License; they are outside its scope.  The act of
+running the Program is not restricted, and the output from the Program
+is covered only if its contents constitute a work based on the
+Program (independent of having been made by running the Program).
+Whether that is true depends on what the Program does.
+
+  1. You may copy and distribute verbatim copies of the Program's
+source code as you receive it, in any medium, provided that you
+conspicuously and appropriately publish on each copy an appropriate
+copyright notice and disclaimer of warranty; keep intact all the
+notices that refer to this License and to the absence of any warranty;
+and give any other recipients of the Program a copy of this License
+along with the Program.
+
+You may charge a fee for the physical act of transferring a copy, and
+you may at your option offer warranty protection in exchange for a fee.
+
+  2. You may modify your copy or copies of the Program or any portion
+of it, thus forming a work based on the Program, and copy and
+distribute such modifications or work under the terms of Section 1
+above, provided that you also meet all of these conditions:
+
+    a) You must cause the modified files to carry prominent notices
+    stating that you changed the files and the date of any change.
+
+    b) You must cause any work that you distribute or publish, that in
+    whole or in part contains or is derived from the Program or any
+    part thereof, to be licensed as a whole at no charge to all third
+    parties under the terms of this License.
+
+    c) If the modified program normally reads commands interactively
+    when run, you must cause it, when started running for such
+    interactive use in the most ordinary way, to print or display an
+    announcement including an appropriate copyright notice and a
+    notice that there is no warranty (or else, saying that you provide
+    a warranty) and that users may redistribute the program under
+    these conditions, and telling the user how to view a copy of this
+    License.  (Exception: if the Program itself is interactive but
+    does not normally print such an announcement, your work based on
+    the Program is not required to print an announcement.)
+
+These requirements apply to the modified work as a whole.  If
+identifiable sections of that work are not derived from the Program,
+and can be reasonably considered independent and separate works in
+themselves, then this License, and its terms, do not apply to those
+sections when you distribute them as separate works.  But when you
+distribute the same sections as part of a whole which is a work based
+on the Program, the distribution of the whole must be on the terms of
+this License, whose permissions for other licensees extend to the
+entire whole, and thus to each and every part regardless of who wrote it.
+
+Thus, it is not the intent of this section to claim rights or contest
+your rights to work written entirely by you; rather, the intent is to
+exercise the right to control the distribution of derivative or
+collective works based on the Program.
+
+In addition, mere aggregation of another work not based on the Program
+with the Program (or with a work based on the Program) on a volume of
+a storage or distribution medium does not bring the other work under
+the scope of this License.
+
+  3. You may copy and distribute the Program (or a work based on it,
+under Section 2) in object code or executable form under the terms of
+Sections 1 and 2 above provided that you also do one of the following:
+
+    a) Accompany it with the complete corresponding machine-readable
+    source code, which must be distributed under the terms of Sections
+    1 and 2 above on a medium customarily used for software interchange; or,
+
+    b) Accompany it with a written offer, valid for at least three
+    years, to give any third party, for a charge no more than your
+    cost of physically performing source distribution, a complete
+    machine-readable copy of the corresponding source code, to be
+    distributed under the terms of Sections 1 and 2 above on a medium
+    customarily used for software interchange; or,
+
+    c) Accompany it with the information you received as to the offer
+    to distribute corresponding source code.  (This alternative is
+    allowed only for noncommercial distribution and only if you
+    received the program in object code or executable form with such
+    an offer, in accord with Subsection b above.)
+
+The source code for a work means the preferred form of the work for
+making modifications to it.  For an executable work, complete source
+code means all the source code for all modules it contains, plus any
+associated interface definition files, plus the scripts used to
+control compilation and installation of the executable.  However, as a
+special exception, the source code distributed need not include
+anything that is normally distributed (in either source or binary
+form) with the major components (compiler, kernel, and so on) of the
+operating system on which the executable runs, unless that component
+itself accompanies the executable.
+
+If distribution of executable or object code is made by offering
+access to copy from a designated place, then offering equivalent
+access to copy the source code from the same place counts as
+distribution of the source code, even though third parties are not
+compelled to copy the source along with the object code.
+
+  4. You may not copy, modify, sublicense, or distribute the Program
+except as expressly provided under this License.  Any attempt
+otherwise to copy, modify, sublicense or distribute the Program is
+void, and will automatically terminate your rights under this License.
+However, parties who have received copies, or rights, from you under
+this License will not have their licenses terminated so long as such
+parties remain in full compliance.
+
+  5. You are not required to accept this License, since you have not
+signed it.  However, nothing else grants you permission to modify or
+distribute the Program or its derivative works.  These actions are
+prohibited by law if you do not accept this License.  Therefore, by
+modifying or distributing the Program (or any work based on the
+Program), you indicate your acceptance of this License to do so, and
+all its terms and conditions for copying, distributing or modifying
+the Program or works based on it.
+
+  6. Each time you redistribute the Program (or any work based on the
+Program), the recipient automatically receives a license from the
+original licensor to copy, distribute or modify the Program subject to
+these terms and conditions.  You may not impose any further
+restrictions on the recipients' exercise of the rights granted herein.
+You are not responsible for enforcing compliance by third parties to
+this License.
+
+  7. If, as a consequence of a court judgment or allegation of patent
+infringement or for any other reason (not limited to patent issues),
+conditions are imposed on you (whether by court order, agreement or
+otherwise) that contradict the conditions of this License, they do not
+excuse you from the conditions of this License.  If you cannot
+distribute so as to satisfy simultaneously your obligations under this
+License and any other pertinent obligations, then as a consequence you
+may not distribute the Program at all.  For example, if a patent
+license would not permit royalty-free redistribution of the Program by
+all those who receive copies directly or indirectly through you, then
+the only way you could satisfy both it and this License would be to
+refrain entirely from distribution of the Program.
+
+If any portion of this section is held invalid or unenforceable under
+any particular circumstance, the balance of the section is intended to
+apply and the section as a whole is intended to apply in other
+circumstances.
+
+It is not the purpose of this section to induce you to infringe any
+patents or other property right claims or to contest validity of any
+such claims; this section has the sole purpose of protecting the
+integrity of the free software distribution system, which is
+implemented by public license practices.  Many people have made
+generous contributions to the wide range of software distributed
+through that system in reliance on consistent application of that
+system; it is up to the author/donor to decide if he or she is willing
+to distribute software through any other system and a licensee cannot
+impose that choice.
+
+This section is intended to make thoroughly clear what is believed to
+be a consequence of the rest of this License.
+
+  8. If the distribution and/or use of the Program is restricted in
+certain countries either by patents or by copyrighted interfaces, the
+original copyright holder who places the Program under this License
+may add an explicit geographical distribution limitation excluding
+those countries, so that distribution is permitted only in or among
+countries not thus excluded.  In such case, this License incorporates
+the limitation as if written in the body of this License.
+
+  9. The Free Software Foundation may publish revised and/or new versions
+of the General Public License from time to time.  Such new versions will
+be similar in spirit to the present version, but may differ in detail to
+address new problems or concerns.
+
+Each version is given a distinguishing version number.  If the Program
+specifies a version number of this License which applies to it and "any
+later version", you have the option of following the terms and conditions
+either of that version or of any later version published by the Free
+Software Foundation.  If the Program does not specify a version number of
+this License, you may choose any version ever published by the Free Software
+Foundation.
+
+  10. If you wish to incorporate parts of the Program into other free
+programs whose distribution conditions are different, write to the author
+to ask for permission.  For software which is copyrighted by the Free
+Software Foundation, write to the Free Software Foundation; we sometimes
+make exceptions for this.  Our decision will be guided by the two goals
+of preserving the free status of all derivatives of our free software and
+of promoting the sharing and reuse of software generally.
+
+			    NO WARRANTY
+
+  11. BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
+FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN
+OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
+PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED
+OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE ENTIRE RISK AS
+TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU.  SHOULD THE
+PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,
+REPAIR OR CORRECTION.
+
+  12. IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
+WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
+REDISTRIBUTE THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES,
+INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING
+OUT OF THE USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED
+TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY
+YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER
+PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
+POSSIBILITY OF SUCH DAMAGES.
+
+		     END OF TERMS AND CONDITIONS
+
+	    How to Apply These Terms to Your New Programs
+
+  If you develop a new program, and you want it to be of the greatest
+possible use to the public, the best way to achieve this is to make it
+free software which everyone can redistribute and change under these terms.
+
+  To do so, attach the following notices to the program.  It is safest
+to attach them to the start of each source file to most effectively
+convey the exclusion of warranty; and each file should have at least
+the "copyright" line and a pointer to where the full notice is found.
+
+    <one line to give the program's name and a brief idea of what it does.>
+    Copyright (C) <year>  <name of author>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+
+
+Also add information on how to contact you by electronic and paper mail.
+
+If the program is interactive, make it output a short notice like this
+when it starts in an interactive mode:
+
+    Gnomovision version 69, Copyright (C) year name of author
+    Gnomovision comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
+    This is free software, and you are welcome to redistribute it
+    under certain conditions; type `show c' for details.
+
+The hypothetical commands `show w' and `show c' should show the appropriate
+parts of the General Public License.  Of course, the commands you use may
+be called something other than `show w' and `show c'; they could even be
+mouse-clicks or menu items--whatever suits your program.
+
+You should also get your employer (if you work as a programmer) or your
+school, if any, to sign a "copyright disclaimer" for the program, if
+necessary.  Here is a sample; alter the names:
+
+  Yoyodyne, Inc., hereby disclaims all copyright interest in the program
+  `Gnomovision' (which makes passes at compilers) written by James Hacker.
+
+  <signature of Ty Coon>, 1 April 1989
+  Ty Coon, President of Vice
+
+This General Public License does not permit incorporating your program into
+proprietary programs.  If your program is a subroutine library, you may
+consider it more useful to permit linking proprietary applications with the
+library.  If this is what you want to do, use the GNU Library General
+Public License instead of this License.
diff --git a/drivers/staging/rtl8188eu/Kconfig b/drivers/staging/rtl8188eu/Kconfig
new file mode 100644
index 000000000000..970d5abd6336
--- /dev/null
+++ b/drivers/staging/rtl8188eu/Kconfig
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0
+config R8188EU
+	tristate "Realtek RTL8188EU Wireless LAN NIC driver"
+	depends on WLAN && USB && CFG80211
+	depends on m
+	select WIRELESS_EXT
+	select WEXT_PRIV
+	select LIB80211
+	select LIB80211_CRYPT_WEP
+	select LIB80211_CRYPT_CCMP
+	help
+	This option adds the Realtek RTL8188EU USB device such as TP-Link TL-WN725N.
+	If built as a module, it will be called r8188eu.
+
+if R8188EU
+
+config 88EU_AP_MODE
+	bool "Realtek RTL8188EU AP mode"
+	default y
+	help
+	This option enables Access Point mode. Unless you know that your system
+	will never be used as an AP, or the target system has limited memory,
+	"Y" should be selected.
+
+endif
diff --git a/drivers/staging/rtl8188eu/Makefile b/drivers/staging/rtl8188eu/Makefile
new file mode 100755
index 000000000000..6c30c8d95b87
--- /dev/null
+++ b/drivers/staging/rtl8188eu/Makefile
@@ -0,0 +1,509 @@
+EXTRA_CFLAGS += $(USER_EXTRA_CFLAGS)
+EXTRA_CFLAGS += -O1 -g
+#EXTRA_CFLAGS += -O3
+#EXTRA_CFLAGS += -Wall
+#EXTRA_CFLAGS += -Wextra
+#EXTRA_CFLAGS += -Werror
+#EXTRA_CFLAGS += -pedantic
+#EXTRA_CFLAGS += -Wshadow -Wpointer-arith -Wcast-qual -Wstrict-prototypes -Wmissing-prototypes
+
+EXTRA_CFLAGS += -Wno-unused-variable
+EXTRA_CFLAGS += -Wno-unused-value
+EXTRA_CFLAGS += -Wno-unused-label
+EXTRA_CFLAGS += -Wno-unused-parameter
+EXTRA_CFLAGS += -Wno-unused-function
+EXTRA_CFLAGS += -Wno-unused
+EXTRA_CFLAGS += -Wno-uninitialized
+
+GCC_VER_49 := $(shell echo `$(CC) -dumpversion | cut -f1-2 -d.` \>= 4.9 | bc )
+ifeq ($(GCC_VER_49),1)
+EXTRA_CFLAGS += -Wno-date-time	# Fix compile error && warning on gcc 4.9 and later
+endif
+
+EXTRA_CFLAGS += -I$(src)/include
+EXTRA_CFLAGS += -I$(src)/hal
+
+#EXTRA_LDFLAGS += --strip-debug
+
+CONFIG_AUTOCFG_CP = n
+
+########################## Features ###########################
+CONFIG_MP_INCLUDED = y
+CONFIG_POWER_SAVING = y
+CONFIG_USB_AUTOSUSPEND = n
+CONFIG_HW_PWRP_DETECTION = n
+CONFIG_WIFI_TEST = n
+CONFIG_BT_COEXIST = n
+CONFIG_INTEL_WIDI = n
+CONFIG_WAPI_SUPPORT = n
+CONFIG_EFUSE_CONFIG_FILE = y
+CONFIG_EXT_CLK = n
+CONFIG_TRAFFIC_PROTECT = y
+CONFIG_LOAD_PHY_PARA_FROM_FILE = y
+CONFIG_TXPWR_BY_RATE_EN = n
+CONFIG_TXPWR_LIMIT_EN = n
+CONFIG_RTW_ADAPTIVITY_EN = disable
+CONFIG_RTW_ADAPTIVITY_MODE = normal
+CONFIG_SIGNAL_SCALE_MAPPING = n
+CONFIG_80211W = n
+CONFIG_REDUCE_TX_CPU_LOADING = n
+CONFIG_BR_EXT = y
+CONFIG_TDLS = n
+CONFIG_WIFI_MONITOR = n
+CONFIG_MCC_MODE = n
+CONFIG_APPEND_VENDOR_IE_ENABLE = n
+CONFIG_RTW_NAPI = y
+CONFIG_RTW_GRO = y
+########################## Debug ###########################
+CONFIG_RTW_DEBUG = y
+# default log level is _DRV_INFO_ = 4,
+# please refer to "How_to_set_driver_debug_log_level.doc" to set the available level.
+CONFIG_RTW_LOG_LEVEL = 2
+######################## Wake On Lan ##########################
+CONFIG_WOWLAN = n
+CONFIG_GPIO_WAKEUP = n
+CONFIG_DEFAULT_PATTERNS_EN = n
+CONFIG_WAKEUP_GPIO_IDX = default
+CONFIG_HIGH_ACTIVE = n
+CONFIG_PNO_SUPPORT = n
+CONFIG_PNO_SET_DEBUG = n
+CONFIG_AP_WOWLAN = n
+######### Notify SDIO Host Keep Power During Syspend ##########
+CONFIG_RTW_SDIO_PM_KEEP_POWER = y
+###################### MP HW TX MODE FOR VHT #######################
+CONFIG_MP_VHT_HW_TX_MODE = n
+###################### Platform Related #######################
+CONFIG_PLATFORM_I386_PC = y
+###############################################################
+
+CONFIG_DRVEXT_MODULE = n
+
+export TopDIR ?= $(CURDIR)
+
+MSG="Directory .git does not exist indicating that you downloaded the source as a zip file. Only the 'git clone' method is now supported."
+
+########### COMMON  #################################
+
+HCI_NAME = usb
+
+_OS_INTFS_FILES :=	os_dep/osdep_service.o \
+			os_dep/os_intfs.o \
+			os_dep/$(HCI_NAME)_intf.o \
+			os_dep/$(HCI_NAME)_ops_linux.o \
+			os_dep/ioctl_linux.o \
+			os_dep/xmit_linux.o \
+			os_dep/mlme_linux.o \
+			os_dep/recv_linux.o \
+			os_dep/ioctl_cfg80211.o \
+			os_dep/rtw_cfgvendor.o \
+			os_dep/wifi_regd.o \
+			os_dep/rtw_android.o \
+			os_dep/rtw_proc.o
+
+ifeq ($(CONFIG_MP_INCLUDED), y)
+_OS_INTFS_FILES += os_dep/ioctl_mp.o
+endif
+
+_HAL_INTFS_FILES :=	hal/hal_intf.o \
+			hal/hal_com.o \
+			hal/hal_com_phycfg.o \
+			hal/hal_phy.o \
+			hal/hal_dm.o \
+			hal/hal_btcoex_wifionly.o \
+			hal/hal_btcoex.o \
+			hal/hal_mp.o \
+			hal/hal_mcc.o \
+			hal/hal_$(HCI_NAME).o \
+			hal/hal_$(HCI_NAME)_led.o
+
+			
+_OUTSRC_FILES := hal/phydm_debug.o	\
+		hal/phydm_antdiv.o\
+		hal/phydm_antdect.o\
+		hal/phydm_interface.o\
+		hal/phydm_hwconfig.o\
+		hal/phydm.o\
+		hal/halphyrf_ce.o\
+		hal/phydm_edcaturbocheck.o\
+		hal/phydm_dig.o\
+		hal/phydm_pathdiv.o\
+		hal/phydm_rainfo.o\
+		hal/phydm_dynamicbbpowersaving.o\
+		hal/phydm_powertracking_ce.o\
+		hal/phydm_dynamictxpower.o\
+		hal/phydm_adaptivity.o\
+		hal/phydm_cfotracking.o\
+		hal/phydm_noisemonitor.o\
+		hal/phydm_acs.o\
+		hal/phydm_dfs.o\
+		hal/phydm_hal_txbf_api.o\
+		hal/phydm_adc_sampling.o\
+		hal/phydm_kfree.o\
+		hal/phydm_ccx.o
+
+
+EXTRA_CFLAGS += -I$(src)/platform
+
+EXTRA_CFLAGS += -I$(src)/hal/btc
+
+RTL871X = rtl8188e
+
+_HAL_INTFS_FILES +=	hal/HalPwrSeqCmd.o \
+					hal/Hal8188EPwrSeq.o\
+ 					hal/$(RTL871X)_xmit.o\
+					hal/$(RTL871X)_sreset.o
+
+_HAL_INTFS_FILES +=	hal/$(RTL871X)_hal_init.o \
+			hal/$(RTL871X)_phycfg.o \
+			hal/$(RTL871X)_rf6052.o \
+			hal/$(RTL871X)_dm.o \
+			hal/$(RTL871X)_rxdesc.o \
+			hal/$(RTL871X)_cmd.o \
+			hal/hal8188e_s_fw.o \
+			hal/hal8188e_t_fw.o \
+			hal/$(HCI_NAME)_halinit.o \
+			hal/rtl8188eu_led.o \
+			hal/rtl8188eu_xmit.o \
+			hal/rtl8188eu_recv.o
+
+_HAL_INTFS_FILES += hal/$(HCI_NAME)_ops_linux.o
+
+_HAL_INTFS_FILES +=hal/HalEfuseMask8188E_USB.o
+
+#hal/OUTSRC/Hal8188EFWImg_CE.o
+_OUTSRC_FILES += hal/halhwimg8188e_mac.o\
+		hal/halhwimg8188e_bb.o\
+		hal/halhwimg8188e_rf.o\
+		hal/halphyrf_8188e_ce.o\
+		hal/phydm_regconfig8188e.o\
+		hal/hal8188erateadaptive.o\
+		hal/phydm_rtl8188e.o
+
+########### AUTO_CFG  #################################
+
+ifeq ($(CONFIG_AUTOCFG_CP), y)
+
+ifeq ($(CONFIG_MULTIDRV), y)
+$(shell cp $(TopDIR)/autoconf_multidrv_$(HCI_NAME)_linux.h $(TopDIR)/include/autoconf.h)
+endif
+
+endif
+
+########### END OF PATH  #################################
+
+ifeq ($(CONFIG_USB_AUTOSUSPEND), y)
+EXTRA_CFLAGS += -DCONFIG_USB_AUTOSUSPEND
+endif
+
+ifeq ($(CONFIG_MP_INCLUDED), y)
+#MODULE_NAME := 8188eu_mp
+EXTRA_CFLAGS += -DCONFIG_MP_INCLUDED
+endif
+
+ifeq ($(CONFIG_POWER_SAVING), y)
+EXTRA_CFLAGS += -DCONFIG_POWER_SAVING
+endif
+
+ifeq ($(CONFIG_HW_PWRP_DETECTION), y)
+EXTRA_CFLAGS += -DCONFIG_HW_PWRP_DETECTION
+endif
+
+ifeq ($(CONFIG_WIFI_TEST), y)
+EXTRA_CFLAGS += -DCONFIG_WIFI_TEST
+endif
+
+ifeq ($(CONFIG_BT_COEXIST), y)
+EXTRA_CFLAGS += -DCONFIG_BT_COEXIST
+endif
+
+ifeq ($(CONFIG_INTEL_WIDI), y)
+EXTRA_CFLAGS += -DCONFIG_INTEL_WIDI
+endif
+
+ifeq ($(CONFIG_WAPI_SUPPORT), y)
+EXTRA_CFLAGS += -DCONFIG_WAPI_SUPPORT
+endif
+
+
+ifeq ($(CONFIG_EFUSE_CONFIG_FILE), y)
+EXTRA_CFLAGS += -DCONFIG_EFUSE_CONFIG_FILE
+
+#EFUSE_MAP_PATH
+USER_EFUSE_MAP_PATH ?=
+ifneq ($(USER_EFUSE_MAP_PATH),)
+EXTRA_CFLAGS += -DEFUSE_MAP_PATH=\"$(USER_EFUSE_MAP_PATH)\"
+else ifeq (r8188eu, 8189es)
+EXTRA_CFLAGS += -DEFUSE_MAP_PATH=\"/system/etc/wifi/wifi_efuse_8189e.map\"
+else ifeq (r8188eu, 8723bs)
+EXTRA_CFLAGS += -DEFUSE_MAP_PATH=\"/system/etc/wifi/wifi_efuse_8723bs.map\"
+else
+EXTRA_CFLAGS += -DEFUSE_MAP_PATH=\"/system/etc/wifi/wifi_efuse_8188eu.map\"
+endif
+
+#WIFIMAC_PATH
+USER_WIFIMAC_PATH ?=
+ifneq ($(USER_WIFIMAC_PATH),)
+EXTRA_CFLAGS += -DWIFIMAC_PATH=\"$(USER_WIFIMAC_PATH)\"
+else
+EXTRA_CFLAGS += -DWIFIMAC_PATH=\"/data/wifimac.txt\"
+endif
+
+endif
+
+ifeq ($(CONFIG_EXT_CLK), y)
+EXTRA_CFLAGS += -DCONFIG_EXT_CLK
+endif
+
+ifeq ($(CONFIG_TRAFFIC_PROTECT), y)
+EXTRA_CFLAGS += -DCONFIG_TRAFFIC_PROTECT
+endif
+
+ifeq ($(CONFIG_LOAD_PHY_PARA_FROM_FILE), y)
+EXTRA_CFLAGS += -DCONFIG_LOAD_PHY_PARA_FROM_FILE
+#EXTRA_CFLAGS += -DREALTEK_CONFIG_PATH_WITH_IC_NAME_FOLDER
+#EXTRA_CFLAGS += -DREALTEK_CONFIG_PATH=\"/lib/firmware/\"
+EXTRA_CFLAGS += -DREALTEK_CONFIG_PATH=\"\"
+endif
+
+ifeq ($(CONFIG_TXPWR_BY_RATE_EN), n)
+EXTRA_CFLAGS += -DCONFIG_TXPWR_BY_RATE_EN=0
+else ifeq ($(CONFIG_TXPWR_BY_RATE_EN), y)
+EXTRA_CFLAGS += -DCONFIG_TXPWR_BY_RATE_EN=1
+else ifeq ($(CONFIG_TXPWR_BY_RATE_EN), auto)
+EXTRA_CFLAGS += -DCONFIG_TXPWR_BY_RATE_EN=2
+endif
+
+ifeq ($(CONFIG_TXPWR_LIMIT_EN), n)
+EXTRA_CFLAGS += -DCONFIG_TXPWR_LIMIT_EN=0
+else ifeq ($(CONFIG_TXPWR_LIMIT_EN), y)
+EXTRA_CFLAGS += -DCONFIG_TXPWR_LIMIT_EN=1
+else ifeq ($(CONFIG_TXPWR_LIMIT_EN), auto)
+EXTRA_CFLAGS += -DCONFIG_TXPWR_LIMIT_EN=2
+endif
+
+ifeq ($(CONFIG_CALIBRATE_TX_POWER_BY_REGULATORY), y)
+EXTRA_CFLAGS += -DCONFIG_CALIBRATE_TX_POWER_BY_REGULATORY
+endif
+
+ifeq ($(CONFIG_CALIBRATE_TX_POWER_TO_MAX), y)
+EXTRA_CFLAGS += -DCONFIG_CALIBRATE_TX_POWER_TO_MAX
+endif
+
+ifeq ($(CONFIG_RTW_ADAPTIVITY_EN), disable)
+EXTRA_CFLAGS += -DCONFIG_RTW_ADAPTIVITY_EN=0
+else ifeq ($(CONFIG_RTW_ADAPTIVITY_EN), enable)
+EXTRA_CFLAGS += -DCONFIG_RTW_ADAPTIVITY_EN=1
+endif
+
+ifeq ($(CONFIG_RTW_ADAPTIVITY_MODE), normal)
+EXTRA_CFLAGS += -DCONFIG_RTW_ADAPTIVITY_MODE=0
+else ifeq ($(CONFIG_RTW_ADAPTIVITY_MODE), carrier_sense)
+EXTRA_CFLAGS += -DCONFIG_RTW_ADAPTIVITY_MODE=1
+endif
+
+ifeq ($(CONFIG_SIGNAL_SCALE_MAPPING), y)
+EXTRA_CFLAGS += -DCONFIG_SIGNAL_SCALE_MAPPING
+endif
+
+ifeq ($(CONFIG_80211W), y)
+EXTRA_CFLAGS += -DCONFIG_IEEE80211W
+endif
+
+ifeq ($(CONFIG_WOWLAN), y)
+EXTRA_CFLAGS += -DCONFIG_WOWLAN
+ifeq ($(CONFIG_DEFAULT_PATTERNS_EN), y)
+EXTRA_CFLAGS += -DCONFIG_DEFAULT_PATTERNS_EN
+endif
+endif
+
+ifeq ($(CONFIG_AP_WOWLAN), y)
+EXTRA_CFLAGS += -DCONFIG_AP_WOWLAN
+endif
+
+ifeq ($(CONFIG_PNO_SUPPORT), y)
+EXTRA_CFLAGS += -DCONFIG_PNO_SUPPORT
+ifeq ($(CONFIG_PNO_SET_DEBUG), y)
+EXTRA_CFLAGS += -DCONFIG_PNO_SET_DEBUG
+endif
+endif
+
+ifeq ($(CONFIG_GPIO_WAKEUP), y)
+EXTRA_CFLAGS += -DCONFIG_GPIO_WAKEUP
+ifeq ($(CONFIG_HIGH_ACTIVE), y)
+EXTRA_CFLAGS += -DHIGH_ACTIVE=1
+else
+EXTRA_CFLAGS += -DHIGH_ACTIVE=0
+endif
+endif
+
+ifneq ($(CONFIG_WAKEUP_GPIO_IDX), default)
+EXTRA_CFLAGS += -DWAKEUP_GPIO_IDX=$(CONFIG_WAKEUP_GPIO_IDX)
+endif
+
+ifeq ($(CONFIG_REDUCE_TX_CPU_LOADING), y)
+EXTRA_CFLAGS += -DCONFIG_REDUCE_TX_CPU_LOADING
+endif
+
+ifeq ($(CONFIG_BR_EXT), y)
+BR_NAME = br0
+EXTRA_CFLAGS += -DCONFIG_BR_EXT
+EXTRA_CFLAGS += '-DCONFIG_BR_EXT_BRNAME="'$(BR_NAME)'"'
+endif
+
+
+ifeq ($(CONFIG_TDLS), y)
+EXTRA_CFLAGS += -DCONFIG_TDLS
+endif
+
+ifeq ($(CONFIG_WIFI_MONITOR), y)
+EXTRA_CFLAGS += -DCONFIG_WIFI_MONITOR
+endif
+
+ifeq ($(CONFIG_MCC_MODE), y)
+EXTRA_CFLAGS += -DCONFIG_MCC_MODE
+endif
+
+ifeq ($(CONFIG_RTW_NAPI), y)
+EXTRA_CFLAGS += -DCONFIG_RTW_NAPI
+endif
+
+ifeq ($(CONFIG_RTW_GRO), y)
+EXTRA_CFLAGS += -DCONFIG_RTW_GRO
+endif
+
+ifeq ($(CONFIG_MP_VHT_HW_TX_MODE), y)
+EXTRA_CFLAGS += -DCONFIG_MP_VHT_HW_TX_MODE
+ifeq ($(CONFIG_PLATFORM_I386_PC), y)
+## For I386 X86 ToolChain use Hardware FLOATING
+EXTRA_CFLAGS += -mhard-float
+else
+## For ARM ToolChain use Hardware FLOATING
+EXTRA_CFLAGS += -mfloat-abi=hard
+endif
+endif
+
+ifeq ($(CONFIG_APPEND_VENDOR_IE_ENABLE), y)
+EXTRA_CFLAGS += -DCONFIG_APPEND_VENDOR_IE_ENABLE
+endif
+
+ifeq ($(CONFIG_RTW_DEBUG), y)
+EXTRA_CFLAGS += -DCONFIG_RTW_DEBUG
+EXTRA_CFLAGS += -DRTW_LOG_LEVEL=$(CONFIG_RTW_LOG_LEVEL)
+endif
+
+EXTRA_CFLAGS += -DDM_ODM_SUPPORT_TYPE=0x04
+
+EXTRA_CFLAGS += -DRTW_USE_CFG80211_STA_EVENT
+
+SUBARCH := $(shell uname -m | sed -e "s/i.86/i386/; s/ppc.*/powerpc/; s/armv.l/arm/; s/aarch64/arm64/;")
+ARCH ?= $(SUBARCH)
+CROSS_COMPILE ?=
+KVER  ?= $(if $(KERNELRELEASE),$(KERNELRELEASE),$(shell uname -r))
+KSRC := /lib/modules/$(KVER)/build
+MODDESTDIR := /lib/modules/$(KVER)/kernel/drivers/net/wireless/
+INSTALL_PREFIX :=
+
+ifeq ($(CONFIG_MULTIDRV), y)
+
+
+MODULE_NAME := rtw_usb
+
+endif
+
+USER_MODULE_NAME ?=
+ifneq ($(USER_MODULE_NAME),)
+MODULE_NAME := $(USER_MODULE_NAME)
+endif
+
+ifneq ($(KERNELRELEASE),)
+
+rtk_core :=	core/rtw_cmd.o \
+		core/rtw_security.o \
+		core/rtw_debug.o \
+		core/rtw_io.o \
+		core/rtw_ioctl_query.o \
+		core/rtw_ioctl_set.o \
+		core/rtw_ieee80211.o \
+		core/rtw_mlme.o \
+		core/rtw_mlme_ext.o \
+		core/rtw_mi.o \
+		core/rtw_wlan_util.o \
+		core/rtw_pwrctrl.o \
+		core/rtw_rf.o \
+		core/rtw_recv.o \
+		core/rtw_sta_mgt.o \
+		core/rtw_ap.o \
+		core/rtw_xmit.o	\
+		core/rtw_p2p.o \
+		core/rtw_tdls.o \
+		core/rtw_br_ext.o \
+		core/rtw_iol.o \
+		core/rtw_sreset.o \
+		core/rtw_btcoex_wifionly.o \
+		core/rtw_btcoex.o \
+		core/rtw_beamforming.o \
+		core/rtw_odm.o \
+		core/rtw_efuse.o 
+
+r8188eu-y += $(rtk_core)
+
+r8188eu-$(CONFIG_INTEL_WIDI) += core/rtw_intel_widi.o
+
+r8188eu-$(CONFIG_WAPI_SUPPORT) += core/rtw_wapi.o	\
+					core/rtw_wapi_sms4.o
+
+r8188eu-y += $(_OS_INTFS_FILES)
+r8188eu-y += $(_HAL_INTFS_FILES)
+r8188eu-y += $(_OUTSRC_FILES)
+
+r8188eu-$(CONFIG_MP_INCLUDED) += core/rtw_mp.o
+
+ifeq ($(CONFIG_RTL8723B), y)
+r8188eu-$(CONFIG_MP_INCLUDED)+= core/rtw_bt_mp.o
+endif
+
+obj-m := r8188eu.o
+
+else
+
+all: test modules
+
+test:
+	@if [ !  -e  ./.git ] ; then echo $(MSG); exit 1; fi;
+
+modules:
+	$(MAKE) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C $(KSRC) M=$(CURDIR)  modules
+
+strip:
+	$(CROSS_COMPILE)strip r8188eu.ko --strip-unneeded
+
+install:
+	install -p -m 644 r8188eu.ko  $(MODDESTDIR)
+	/sbin/depmod -a ${KVER}
+
+uninstall:
+	rm -f $(MODDESTDIR)/r8188eu.ko
+	/sbin/depmod -a ${KVER}
+
+config_r:
+	@echo "make config"
+	/bin/bash script/Configure script/config.in
+
+
+.PHONY: modules clean
+
+clean:
+	#$(MAKE) -C $(KSRC) M=$(CURDIR) clean
+	cd hal ; rm -fr */*/*/*.mod.c */*/*/*.mod */*/*/*.o */*/*/.*.cmd */*/*/*.ko
+	cd hal ; rm -fr */*/*.mod.c */*/*.mod */*/*.o */*/.*.cmd */*/*.ko
+	cd hal ; rm -fr */*.mod.c */*.mod */*.o */.*.cmd */*.ko
+	cd hal/led ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko .*.cmd
+	cd core ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko
+	cd os_dep/linux ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko
+	cd os_dep ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko
+	cd platform ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko
+	rm -fr Module.symvers ; rm -fr Module.markers ; rm -fr modules.order
+	rm -fr *.mod.c *.mod *.o .*.cmd *.ko *~
+	rm -fr .tmp_versions
+endif
+
-- 
2.31.1

